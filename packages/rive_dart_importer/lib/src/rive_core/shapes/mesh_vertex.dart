import 'package:rive_dart_importer/src/generated/shapes/mesh_vertex_base.dart';
import 'package:rive_dart_importer/src/rive_core/shapes/mesh.dart';

export 'package:rive_dart_importer/src/generated/shapes/mesh_vertex_base.dart';

class MeshVertex extends MeshVertexBase {
  Mesh? get mesh => parent as Mesh?;

  @override
  bool validate() => super.validate() && parent is Mesh;

  @override
  void uChanged(double from, double to) {}

  @override
  void vChanged(double from, double to) {}

  @override
  void xChanged(double from, double to) {}

  @override
  void yChanged(double from, double to) {}
}
