// Core automatically generated
// lib/src/generated/animation/listener_number_change_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/listener_action_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/listener_input_change.dart';

abstract class ListenerNumberChangeBase extends ListenerInputChange {
  static const int typeKey = 118;
  @override
  int get coreType => ListenerNumberChangeBase.typeKey;
  @override
  Set<int> get coreTypes => {
        ListenerNumberChangeBase.typeKey,
        ListenerInputChangeBase.typeKey,
        ListenerActionBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// Value field with key 229.
  static const int valuePropertyKey = 229;
  static const double valueInitialValue = 0;
  double _value = valueInitialValue;

  /// Value to set the input to when the listener occurs.
  double get value => _value;

  /// Change the [_value] field value.
  /// [valueChanged] will be invoked only if the field's value has changed.
  set value(double value) {
    if (_value == value) {
      return;
    }
    double from = _value;
    _value = value;
    if (hasValidated) {
      valueChanged(from, value);
    }
  }

  void valueChanged(double from, double to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is ListenerNumberChangeBase) {
      _value = source._value;
    }
  }
}
