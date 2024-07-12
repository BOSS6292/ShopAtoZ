const String collectionBrand = 'Brands';
const String brandFieldId = 'Id';
const String brandFieldName = 'name';

class Brand {
  String? id;
  String name;

  Brand({this.id, required this.name});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      brandFieldId: id,
      brandFieldName: name,
    };
  }

  factory Brand.fromJson(Map<String, dynamic> map) => Brand(
    id: map[brandFieldId],
    name: map[brandFieldName],
  );

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;
    return other is Brand && other.id == id && other.name == name;
  }

  @override
  int get hashCode => Object.hash(id, name);

}