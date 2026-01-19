class PostEntity {
  final String id;
  final String authorName;
  final String authorImage;
  final String title;
  final String body;
  final DateTime createdAt;

  PostEntity({
    this.id = '',
    required this.authorName,
    required this.authorImage,
    required this.title,
    required this.body,
    required this.createdAt,
  });
}
