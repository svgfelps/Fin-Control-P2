class CategoryModel {
  String? id;
  String name;
  String type;
  String description;
  String color;
  String userId;

  CategoryModel({
    this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.color,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'description': description,
      'color': color,
      'userId': userId,
    };
  }

  factory CategoryModel.fromMap(
    String id,
    Map<String, dynamic> data,
  ) {
    return CategoryModel(
      id: id,
      name: data['name'] ?? '',
      type: data['type'] ?? '',
      description: data['description'] ?? '',
      color: data['color'] ?? '',
      userId: data['userId'] ?? '',
    );
  }
}