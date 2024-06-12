import 'dart:async';

import 'package:rive_dart_importer/src/rive_core/assets/audio_asset.dart';
import 'package:rive_common/rive_audio.dart';

class AudioPlayer {
  final ValueNotifier<Duration> time = ValueNotifier(Duration.zero);
  final ValueNotifier<double> normalizedTime = ValueNotifier(0);
  final ValueNotifier<bool> isPlaying = ValueNotifier(false);
  AudioEngine? _engine;
  AudioEngine? get engine => _engine;
  final List<AudioSound> _sounds = [];
  int _soundStartTime = 0;
  Duration _soundDuration = Duration.zero;

  Timer? _timer;

  AudioPlayer({required AudioEngine? engine}) : _engine = engine;

  static AudioPlayer? make() {
    var engine = AudioEngine.init(2, AudioEngine.playbackSampleRate);
    if (engine == null) {
      return null;
    }

    return AudioPlayer(engine: engine);
  }

  double get engineTimeInSeconds {
    var engine = this.engine;
    if (engine == null) {
      return 0;
    }
    return engine.timeInFrames / engine.sampleRate;
  }

  void playBuffered(
    BufferedAudioSource source, {
    Duration startTime = Duration.zero,
    Duration? endTime,
    double volume = 1,
  }) {
    var engine = this.engine;
    if (engine == null) {
      return;
    }

    if (startTime > source.duration) {
      return;
    }

    var engineTime = engine.timeInFrames;

    isPlaying.value = true;

    var sound = engine.play(
        source,
        engineTime,
        endTime == null
            ? 0
            : (engineTime +
                    (endTime - startTime).inMicroseconds *
                        1e-6 *
                        engine.sampleRate)
                .round(),
        (startTime.inMicroseconds * 1e-6 * engine.sampleRate).round());
    if (volume != 1) {
      sound.volume = volume;
    }
    _sounds.add(sound);
    _soundDuration = source.duration;
    _soundStartTime = engineTime -
        (startTime.inMicroseconds * 1e-6 * engine.sampleRate).round();
    _timer ??= Timer.periodic(const Duration(milliseconds: 0), _frameCallback);
  }

  bool playSource(AudioAsset? audio) {
    var source = audio?.audioSource.value;
    if (source == null) {
      return false;
    }
    var engine = this.engine;
    if (engine == null) {
      return false;
    }

    var engineTime = engine.timeInFrames;

    var sound = engine.play(source, engineTime, 0, 0);
    if (audio?.volume != 1) {
      sound.volume = audio?.volume ?? 1;
    }
    _sounds.add(sound);
    _timer ??= Timer.periodic(const Duration(milliseconds: 0), _frameCallback);
    return true;
  }

  void _frameCallback(Timer timer) {
    var engine = this.engine;
    if (engine == null) {
      return;
    }
    var elapsedAudioFrames = engine.timeInFrames - _soundStartTime;
    time.value = Duration(
        microseconds: (elapsedAudioFrames / engine.sampleRate / 1e-6).floor());
    normalizedTime.value = _soundDuration == Duration.zero
        ? 0
        : (time.value.inMicroseconds / _soundDuration.inMicroseconds)
            .clamp(0, 1);

    var completed = _sounds.where((sound) => sound.completed).toList();

    _sounds.removeWhere((sound) => sound.completed);
    for (final sound in completed) {
      sound.dispose();
    }
  }

  void stop() {
    isPlaying.value = false;
    _timer?.cancel();
    _timer = null;

    time.value = Duration.zero;
    normalizedTime.value = 0;
    for (final sound in _sounds) {
      sound.stop();
      sound.dispose();
    }
    _sounds.clear();
  }

  void dispose() {
    var engine = this.engine;
    if (engine == null) {
      return;
    }
    stop();
    engine.dispose();
    _engine = null;
  }
}
