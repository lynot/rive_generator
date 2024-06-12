// Core automatically generated
// lib/src/generated/animation/listener_input_change_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/rive_core/animation/listener_action.dart';

abstract class ListenerInputChangeBase extends ListenerAction {
  static const int typeKey = 116;
  @override
  int get coreType => ListenerInputChangeBase.typeKey;
  @override
  Set<int> get coreTypes =>
      {ListenerInputChangeBase.typeKey, ListenerActionBase.typeKey};

  /// --------------------------------------------------------------------------
  /// InputId field with key 227.
  static const int inputIdPropertyKey = 227;
  static const int inputIdInitialValue = -1;
  int _inputId = inputIdInitialValue;

  /// Id of the StateMachineInput referenced.
  int get inputId => _inputId;

  /// Change the [_inputId] field value.
  /// [inputIdChanged] will be invoked only if the field's value has changed.
  set inputId(int value) {
    if (_inputId == value) {
      return;
    }
    int from = _inputId;
    _inputId = value;
    if (hasValidated) {
      inputIdChanged(from, value);
    }
  }

  void inputIdChanged(int from, int to);

  /// --------------------------------------------------------------------------
  /// NestedInputId field with key 400.
  static const int nestedInputIdPropertyKey = 400;
  static const int nestedInputIdInitialValue = -1;
  int _nestedInputId = nestedInputIdInitialValue;

  /// Id of the NestedInput referenced if this is listening to a nested input.
  int get nestedInputId => _nestedInputId;

  /// Change the [_nestedInputId] field value.
  /// [nestedInputIdChanged] will be invoked only if the field's value has
  /// changed.
  set nestedInputId(int value) {
    if (_nestedInputId == value) {
      return;
    }
    int from = _nestedInputId;
    _nestedInputId = value;
    if (hasValidated) {
      nestedInputIdChanged(from, value);
    }
  }

  void nestedInputIdChanged(int from, int to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is ListenerInputChangeBase) {
      _inputId = source._inputId;
      _nestedInputId = source._nestedInputId;
    }
  }
}
