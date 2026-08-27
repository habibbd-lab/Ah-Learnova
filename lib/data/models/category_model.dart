class CategoryModel {
  final int id;
  final String name;
  final String slug;
  final String? icon;
  final String? description;
  final int coursesCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.icon,
    this.description,
    this.coursesCount = 0,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      icon: json['icon'] as String?,
      description: json['description'] as String?,
      coursesCount: json['courses_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'icon': icon,
      'description': description,
      'courses_count': coursesCount,
    };
  }
}
