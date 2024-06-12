import 'package:rive_dart_importer/src/generated/animation/nested_bool_base.dart';
export 'package:rive_dart_importer/src/generated/animation/nested_bool_base.dart';

class NestedBool extends NestedBoolBase {
  @override
  void nestedValueChanged(bool from, bool to) => updateValue();

  @override
  void updateValue() => nestedStateMachine?.setInputValue(inputId, nestedValue);

  @override
  set nestedValue(bool value) {
    super.nestedValue = value;

    updateValue();
  }
}
