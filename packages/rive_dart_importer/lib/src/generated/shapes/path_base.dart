// Core automatically generated lib/src/generated/shapes/path_base.dart.
// Do not modify manually.

import 'package:rive_dart_importer/src/core/core.dart';
import 'package:rive_dart_importer/src/generated/component_base.dart';
import 'package:rive_dart_importer/src/generated/container_component_base.dart';
import 'package:rive_dart_importer/src/generated/transform_component_base.dart';
import 'package:rive_dart_importer/src/generated/world_transform_component_base.dart';
import 'package:rive_dart_importer/src/rive_core/node.dart';

abstract class PathBase extends Node {
  static const int typeKey = 12;
  @override
  int get coreType => PathBase.typeKey;
  @override
  Set<int> get coreTypes => {
        PathBase.typeKey,
        NodeBase.typeKey,
        TransformComponentBase.typeKey,
        WorldTransformComponentBase.typeKey,
        ContainerComponentBase.typeKey,
        ComponentBase.typeKey
      };

  /// --------------------------------------------------------------------------
  /// PathFlags field with key 128.
  static const int pathFlagsPropertyKey = 128;
  static const int pathFlagsInitialValue = 0;
  int _pathFlags = pathFlagsInitialValue;
  int get pathFlags => _pathFlags;

  /// Change the [_pathFlags] field value.
  /// [pathFlagsChanged] will be invoked only if the field's value has changed.
  set pathFlags(int value) {
    if (_pathFlags == value) {
      return;
    }
    int from = _pathFlags;
    _pathFlags = value;
    if (hasValidated) {
      pathFlagsChanged(from, value);
    }
  }

  void pathFlagsChanged(int from, int to);

  @override
  void copy(Core source) {
    super.copy(source);
    if (source is PathBase) {
      _pathFlags = source._pathFlags;
    }
  }
}
