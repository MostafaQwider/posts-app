import '../repositories/post_repository.dart';
import '../entities/comment_entity.dart';

class GetCommentsUseCase {
  final PostRepository repository;

  GetCommentsUseCase(this.repository);

  Future<List<CommentEntity>> call(String postId) async {
    return await repository.getComments(postId);
  }
}
