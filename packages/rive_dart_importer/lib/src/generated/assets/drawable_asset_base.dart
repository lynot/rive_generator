// Core automatically generated
// lib/src/generated/assets/drawable_asset_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/assets/asset_base.dart';
import 'package:rive_dart_importer/src/rive_core/assets/file_asset.dart';

abstract class DrawableAssetBase extends FileAsset {
  static const int typeKey = 104;
  @override
  int get coreType => DrawableAssetBase.typeKey;
  @override
  Set<int> get coreTypes =>
      {DrawableAssetBase.typeKey, FileAssetBase.typeKey, AssetBase.typeKey};

  /// --------------------------------------------------------------------------
  /// Height field with key 207.
  static const int heightPropertyKey = 207;
  static const double heightInitialValue = 0;
  double _height = heightInitialValue;

  /// Height of the original asset uploaded
  double get height => _height;

  /// Change the [_height] field value.
  /// [heightChanged] will be invoked only if the field's value has changed.
  set height(double value) {
    if (_height == value) {
      return;
    }
    double from = _height;
    _height = value;
    if (hasValidated) {
      heightChanged(from, value);
    }
  }

  void heightChanged(double from, double to);

  /// --------------------------------------------------------------------------
  /// Width field with key 208.
  static const int widthPropertyKey = 208;
  static const double widthInitialValue = 0;
  double _width = widthInitialValue;

  /// Width of the original asset uploaded
  double get width => _width;

  /// Change the [_width] field value.
  /// [widthChanged] will be invoked only if the field's value has changed.
  set width(double value) {
    if (_width == value) {
      return;
    }
    double from = _width;
    _width = value;
    if (hasValidated) {
      widthChanged(from, value);
    }
  }

  void widthChanged(double from, double to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is DrawableAssetBase) {
      _height = source._height;
      _width = source._width;
    }
  }
}
