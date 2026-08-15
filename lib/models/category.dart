class Category {
  final String id;
  final String title;
  final String iconName;
  final int totalWords;

  const Category({
    required this.id,
    required this.title,
    required this.iconName,
    required this.totalWords,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'iconName': iconName,
      'totalWords': totalWords,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as String? ?? '',
      title: map['title'] as String? ?? '',
      iconName: map['iconName'] as String? ?? '',
      totalWords: map['totalWords'] as int? ?? 0,
    );
  }
}