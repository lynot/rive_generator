import 'dart:collection';
import 'package:rive_dart_importer/src/rive_core/animation/state_transition.dart';

class StateTransitions extends ListBase<StateTransition> {
  final List<StateTransition?> _values = [];
  List<StateTransition> get values => _values.cast<StateTransition>();

  @override
  int get length => _values.length;

  @override
  set length(int value) => _values.length = value;

  @override
  StateTransition operator [](int index) => _values[index]!;

  @override
  void operator []=(int index, StateTransition value) => _values[index] = value;
}
