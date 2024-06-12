import 'package:rive_dart_importer/src/core/field_types/core_field_type.dart';
import 'package:rive_dart_importer/src/utilities/utilities.dart';

class CoreDoubleType extends CoreFieldType<double> {
  @override
  double deserialize(BinaryReader reader) => reader.readFloat32();
}
