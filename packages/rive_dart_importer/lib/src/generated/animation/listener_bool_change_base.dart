// Core automatically generated
// lib/src/generated/animation/listener_bool_change_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/listener_action_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/listener_input_change.dart';

abstract class ListenerBoolChangeBase extends ListenerInputChange {
  static const int typeKey = 117;
  @override
  int get coreType => ListenerBoolChangeBase.typeKey;
  @override
  Set<int> get coreTypes => {
        ListenerBoolChangeBase.typeKey,
        ListenerInputChangeBase.typeKey,
        ListenerActionBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// Value field with key 228.
  static const int valuePropertyKey = 228;
  static const int valueInitialValue = 1;
  int _value = valueInitialValue;

  /// Value to set the input to when the listener occurs.
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
    if (source is ListenerBoolChangeBase) {
      _value = source._value;
    }
  }
}
