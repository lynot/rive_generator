import 'package:rive_dart_importer/src/generated/animation/state_machine_bool_base.dart';
export 'package:rive_dart_importer/src/generated/animation/state_machine_bool_base.dart';

class StateMachineBool extends StateMachineBoolBase {
  @override
  void valueChanged(bool from, bool to) {}

  @override
  bool isValidType<T>() => T == bool;
}
