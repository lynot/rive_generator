// Core automatically generated
// lib/src/generated/animation/keyframe_id_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/keyframe_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/interpolating_keyframe.dart';

abstract class KeyFrameIdBase extends InterpolatingKeyFrame {
  static const int typeKey = 50;
  @override
  int get coreType => KeyFrameIdBase.typeKey;
  @override
  Set<int> get coreTypes => {
        KeyFrameIdBase.typeKey,
        InterpolatingKeyFrameBase.typeKey,
        KeyFrameBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// Value field with key 122.
  static const int valuePropertyKey = 122;
  static const int valueInitialValue = -1;
  int _value = valueInitialValue;
  int get value => _value;

  /// Change the [_value] field value.
  /// [valueChanged] will be invoked only if the field's value has changed.
  set value(int value) {
    if (_value == value) {
      return;
    }
    int from = _value;
    _value = value;
    if (hasValidated) {
      valueChanged(from, value);
    }
  }

  void valueChanged(int from, int to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is KeyFrameIdBase) {
      _value = source._value;
    }
  }
}
