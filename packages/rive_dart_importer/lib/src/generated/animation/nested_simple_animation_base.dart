// Core automatically generated
// lib/src/generated/animation/nested_simple_animation_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/generated/nested_animation_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/nested_linear_animation.dart';

abstract class NestedSimpleAnimationBase extends NestedLinearAnimation {
  static const int typeKey = 96;
  @override
  int get coreType => NestedSimpleAnimationBase.typeKey;
  @override
  Set<int> get coreTypes => {
        NestedSimpleAnimationBase.typeKey,
        NestedLinearAnimationBase.typeKey,
        NestedAnimationBase.typeKey,
        ContainerComponentBase.typeKey,
        ComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// Speed field with key 199.
  static const int speedPropertyKey = 199;
  static const double speedInitialValue = 1;
  double _speed = speedInitialValue;

  /// Speed to play the nested animation at.
  double get speed => _speed;

  /// Change the [_speed] field value.
  /// [speedChanged] will be invoked only if the field's value has changed.
  set speed(double value) {
    if (_speed == value) {
      return;
    }
    double from = _speed;
    _speed = value;
    if (hasValidated) {
      speedChanged(from, value);
    }
  }

  void speedChanged(double from, double to);

  /// --------------------------------------------------------------------------
  /// IsPlaying field with key 201.
  static const int isPlayingPropertyKey = 201;
  static const bool isPlayingInitialValue = false;
  bool _isPlaying = isPlayingInitialValue;

  /// Enumerated backing value for playback state.
  bool get isPlaying => _isPlaying;

  /// Change the [_isPlaying] field value.
  /// [isPlayingChanged] will be invoked only if the field's value has changed.
  set isPlaying(bool value) {
    if (_isPlaying == value) {
      return;
    }
    bool from = _isPlaying;
    _isPlaying = value;
    if (hasValidated) {
      isPlayingChanged(from, value);
    }
  }

  void isPlayingChanged(bool from, bool to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is NestedSimpleAnimationBase) {
      _speed = source._speed;
      _isPlaying = source._isPlaying;
    }
  }
}
