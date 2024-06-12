import 'package:rive_dart_importer/src/generated/animation/nested_number_base.dart';
export 'package:rive_dart_importer/src/generated/animation/nested_number_base.dart';

class NestedNumber extends NestedNumberBase {
  @override
  void nestedValueChanged(double from, double to) => updateValue();

  @override
  void updateValue() => nestedStateMachine?.setInputValue(inputId, nestedValue);

  @override
  set nestedValue(double value) {
    super.nestedValue = value;

    updateValue();
  }
}
