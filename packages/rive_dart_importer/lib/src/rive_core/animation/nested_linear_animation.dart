import 'package:rive_dart_importer/src/generated/animation/nested_linear_animation_base.dart';
import 'package:rive_dart_importer/src/rive_core/nested_artboard.dart';

export 'package:rive_dart_importer/src/generated/animation/nested_linear_animation_base.dart';

/// Need this abstraction to not depend on package:rive in rive_core.
// ignore: one_member_abstracts
abstract class NestedLinearAnimationInstance {
  void goto(double value);
  double get durationSeconds;

  double get speed;
  set speed(double value);

  bool advance(double elapsedSeconds);
  void apply(covariant MountedArtboard artboard, double mix);
}

abstract class NestedLinearAnimation extends NestedLinearAnimationBase {
  NestedLinearAnimationInstance? _linearAnimationInstance;
  NestedLinearAnimationInstance? get linearAnimationInstance =>
      _linearAnimationInstance;
  set linearAnimationInstance(NestedLinearAnimationInstance? value) {
    if (_linearAnimationInstance == value) {
      return;
    }
    var from = _linearAnimationInstance;
    _linearAnimationInstance = value;
    linearAnimationInstanceChanged(from, value);
  }

  void linearAnimationInstanceChanged(
      NestedLinearAnimationInstance? from, NestedLinearAnimationInstance? to) {}

  @override
  bool get isEnabled => true;

  @override
  void mixChanged(double from, double to) {}

  @override
  bool advance(double elapsedSeconds, MountedArtboard mountedArtboard) {
    if (linearAnimationInstance != null && mix != 0) {
      linearAnimationInstance!.apply(mountedArtboard, mix);
      return true;
    }
    return false;
  }
}
