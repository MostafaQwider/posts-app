import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/post_entity.dart';

class PostModel {
  final PostEntity entity;
  PostModel({required this.entity});

  factory PostModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return PostModel(
      entity: PostEntity(
        id: doc.id,
        authorName: data['authorName'] as String? ?? '',
        authorImage: data['authorImage'] as String? ?? '', // جلب الصورة
        title: data['title'] as String? ?? '',
        body: data['body'] as String? ?? '',
        createdAt: _parseDateTime(data['createdAt']),
      ),
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      entity: PostEntity(
        id: json['id'] as String? ?? '',
        authorName: json['authorName'] as String? ?? '',
        authorImage:
            json['authorImage'] as String? ?? '', // جلب الصورة من الكاش
        title: json['title'] as String? ?? '',
        body: json['body'] as String? ?? '',
        createdAt: _parseDateTime(json['createdAt']),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': entity.id,
      'authorName': entity.authorName,
      'authorImage': entity.authorImage, // حفظ في الكاش
      'title': entity.title,
      'body': entity.body,
      'createdAt': entity.createdAt.toIso8601String(),
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      'authorName': entity.authorName,
      'authorImage': entity.authorImage, // حفظ في فيربيز
      'title': entity.title,
      'body': entity.body,
      'createdAt': Timestamp.fromDate(entity.createdAt),
    };
  }

  static DateTime _parseDateTime(dynamic date) {
    if (date is Timestamp) return date.toDate();
    if (date is String) return DateTime.tryParse(date) ?? DateTime.now();
    return DateTime.now();
  }
}
