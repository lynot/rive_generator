import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:rive_dart_importer/rive.dart';
import 'package:rive_dart_importer/src/debug.dart';
import 'package:rive_dart_importer/src/rive_core/assets/file_asset.dart';
import 'package:rive_dart_importer/src/utilities/utilities.dart';

/// Base class for resolving out of band Rive assets, such as images and fonts.
///
/// See [CallbackAssetLoader] and [LocalAssetLoader] for an example of how to
/// use this.
// ignore: one_member_abstracts
abstract class FileAssetLoader {
  Future<bool> load(FileAsset asset, Uint8List? embeddedBytes);
}

/// Loads assets from Rive's CDN.
///
/// This is used internally by Rive to load assets from the CDN. It is not
/// intended to be used by end users. Instead extend [FileAssetLoader] for
/// custom asset loading, or use [CallbackAssetLoader].
class CDNAssetLoader extends FileAssetLoader {
  CDNAssetLoader();

  @override
  Future<bool> load(FileAsset asset, Uint8List? embeddedBytes) async {
    // if the asset is embedded, or does not have a cdn uuid, do not attempt
    // to load it
    if (embeddedBytes != null || asset.cdnUuid.isEmpty) {
      return false;
    }

    var url = asset.cdnBaseUrl;

    if (!url.endsWith('/')) {
      url += '/';
    }
    url += formatUuid(
      uuidVariant2(asset.cdnUuid),
    );

    final res = await http.get(Uri.parse(url));

    if ((res.statusCode / 100).floor() == 2) {
      try {
        await asset.decode(
          Uint8List.view(res.bodyBytes.buffer),
        );
      } on Exception catch (e) {
        printDebugMessage(
          '''Unable to parse response ${asset.runtimeType}.
  - Url: $url
  - Exception: $e''',
        );
        return false;
      }

      return true;
    } else {
      return false;
    }
  }
}

/// Convenience class for loading assets from the local file system.
///
/// Specify the [fontPath], [imagePath], and [audioPath] to load assets from the
/// asset bundle for a specific asset type. Or use [path] as a general
/// fallback instead. [path] will only be used for an asset type if the
/// corresponding asset path is null.
///
/// For example, to provide an audio asset path:
/// ```dart
/// final riveFile = await RiveFile.asset(
///   'assets/ping_pong_audio_demo.riv',
///   assetLoader: LocalAssetLoader(
///     audioPath: 'assets/some/path',
///     // path: 'assets/some/path', // or provide fallback/general
///   ),
/// );
/// ```
///
/// Be sure to provide the correct path where the file is located.
///
/// If more control is desired, extend [FileAssetLoader] and override [load].
class LocalAssetLoader extends FileAssetLoader {
  final String? audioPath;
  final String? fontPath;
  final String? imagePath;
  final String? path;

  LocalAssetLoader({
    this.audioPath,
    this.fontPath,
    this.imagePath,
    this.path,
  });

  @override
  Future<bool> load(FileAsset asset, Uint8List? embeddedBytes) async {
    // do not load embedded assets.
    if (embeddedBytes != null) {
      return false;
    }
    String? assetPath;

    String filePath;

    switch (asset.runtimeType) {
      case AudioAsset:
        assert(audioPath != null || path != null,
            '''Audio asset not found. Be sure to provide either `audioPath` or `path` in `LocalAssetLoader`.''');
        if (audioPath == null && path == null) return false;
        filePath = audioPath ?? path!;
        break;
      case FontAsset:
        assert(fontPath != null || path != null,
            '''Font asset not found. Be sure to provide either `fontPath` or `path` in `LocalAssetLoader`.''');
        if (fontPath == null && path == null) return false;
        filePath = fontPath ?? path!;
        break;
      case ImageAsset:
        assert(imagePath != null || path != null,
            '''Image asset not found. Be sure to provide either `imagePath` or `path` in `LocalAssetLoader`.''');
        if (imagePath == null && path == null) return false;
        filePath = imagePath ?? path!;
        break;
      default:
        return false;
    }

    filePath = filePath.endsWith("/") ? filePath : "$filePath/";

    assetPath = filePath + asset.uniqueFilename;
    final bytes = await File(assetPath);
    await asset.decode(bytes.readAsBytesSync());
    return true;
  }
}

/// Convenience class that extends [FileAssetLoader] and allows you to
/// register a callback for loading Rive assets.
///
/// The callback will be called for each asset that needs to be loaded manually.
/// See [RiveFile] for additional options. Which assets are embedded are defined
/// within the Rive editor.
///
/// This callback will be triggered for any **referenced** assets.
///
///
/// Set [loadCdnAssets] to false to disable loading
/// assets from the Rive CDN.
///
/// ### Example usage:
/// Loading from assets. Here only assets marked as **referenced** will trigger
/// the callback.
/// ```dart
/// final riveFile = await RiveFile.asset(
///  'assets/asset.riv',
///  loadCdnAssets: true,
///  assetLoader: CallbackAssetLoader(
///    (asset, bytes) async {
///      final res =
///          await http.get(Uri.parse('https://picsum.photos/1000/1000'));
///      await asset.decode(Uint8List.view(res.bodyBytes.buffer));
///      return true;
///    },
///  ),
/// );
/// ```
class CallbackAssetLoader extends FileAssetLoader {
  Future<bool> Function(FileAsset asset, Uint8List? embeddedBytes) callback;

  CallbackAssetLoader(this.callback);

  @override
  Future<bool> load(FileAsset asset, Uint8List? embeddedBytes) async {
    return callback(asset, embeddedBytes);
  }
}

/// Convenience class that extends [FileAssetLoader] and allows you to
/// register fallbacks for loading Rive assets, such as images and fonts.
///
/// For example, you can use this to load assets from the CDN, and if that
/// fails, load them from the asset bundle.
///
/// Alternatively, extend [FileAssetLoader] and override [load] for more
/// custom control in how assets are resolved.
class FallbackAssetLoader extends FileAssetLoader {
  final List<FileAssetLoader> fileAssetLoaders;

  FallbackAssetLoader(this.fileAssetLoaders);

  @override
  Future<bool> load(FileAsset asset, Uint8List? embeddedBytes) async {
    for (var i = 0; i < fileAssetLoaders.length; i++) {
      final resolver = fileAssetLoaders[i];
      final success = await resolver.load(asset, embeddedBytes);
      if (success) {
        return true;
      }
    }
    return false;
  }
}
