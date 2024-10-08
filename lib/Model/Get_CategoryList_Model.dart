class Category {
  final String id;
  final String categoryName;
  final String image;

  Category({required this.id, required this.categoryName, required this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      categoryName: json['category_name'],
      image: json['image'],
    );
  }
}