import 'package:meta/meta.dart';

class PropertyRow {
  String propertyValue;
  List<String> visionValues;

  PropertyRow({
    @required this.propertyValue,
    @required this.visionValues,
  });

  bool operator ==(o) =>
      o is PropertyRow &&
      o.propertyValue == this.propertyValue &&
      o.visionValues == this.visionValues;

  int get hashCode => this.propertyValue.hashCode ^ this.visionValues.hashCode;
}
