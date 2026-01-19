class CommentEntity {
  final String id;
  final String postId;
  final String name;
  final String email;
  final String body;
  final DateTime createdAt;

  CommentEntity(
      {this.id = '',
      required this.postId,
      required this.name,
      required this.email,
      required this.body,
      required this.createdAt});
}
