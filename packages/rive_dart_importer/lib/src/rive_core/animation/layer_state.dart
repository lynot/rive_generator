import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/animation/layer_state_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_instance.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_machine_layer.dart';
import 'package:rive_dart_importer/src/rive_core/animation/state_transition.dart';

export 'package:rive_dart_importer/src/generated/animation/layer_state_base.dart';

abstract class LayerState extends LayerStateBase {
  final StateTransitions _transitions = StateTransitions();
  StateTransitions get transitions => _transitions;

  @override
  void onAdded() {}

  @override
  void onAddedDirty() {}

  void internalAddTransition(StateTransition transition) {
    assert(!_transitions.contains(transition),
        'shouldn\'t already contain the transition');
    _transitions.add(transition);
  }

  void internalRemoveTransition(StateTransition transition) {
    _transitions.remove(transition);
  }

  @override
  void flagsChanged(int from, int to) {}

  StateInstance makeInstance();

  @override
  bool import(ImportStack stack) {
    var importer =
        stack.latest<StateMachineLayerImporter>(StateMachineLayerBase.typeKey);
    if (importer == null) {
      return false;
    }
    importer.addState(this);

    return super.import(stack);
  }
}
