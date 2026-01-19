import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/comment_entity.dart';

class CommentModel {
  final CommentEntity entity;
  CommentModel({required this.entity});

  factory CommentModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return CommentModel(
      entity: CommentEntity(
        id: doc.id,
        postId: data['postId'] as String? ?? '',
        name: data['name'] as String? ?? 'Guest',
        email: data['email'] as String? ?? '',
        body: data['content'] ?? data['body'] ?? '',
        createdAt: _parseDateTime(data['createdAt']),
      ),
    );
  }

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      entity: CommentEntity(
        id: json['id'] as String? ?? '',
        postId: json['postId'] as String? ?? '',
        name: json['name'] as String? ?? '',
        email: json['email'] as String? ?? '',
        body: json['body'] as String? ?? '',
        createdAt: _parseDateTime(json['createdAt']),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': entity.id,
        'postId': entity.postId,
        'name': entity.name,
        'email': entity.email,
        'body': entity.body,
        'createdAt': entity.createdAt.toIso8601String(),
      };

  Map<String, dynamic> toFirestore() => {
        'postId': entity.postId,
        'name': entity.name,
        'email': entity.email,
        'content': entity.body,
        'createdAt': Timestamp.fromDate(entity.createdAt),
      };

  static DateTime _parseDateTime(dynamic date) {
    if (date is Timestamp) return date.toDate();
    if (date is String) return DateTime.tryParse(date) ?? DateTime.now();
    return DateTime.now();
  }
}
