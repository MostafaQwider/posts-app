import '../repositories/post_repository.dart';
import '../entities/comment_entity.dart';

class AddCommentUseCase {
  final PostRepository repository;

  AddCommentUseCase(this.repository);

  Future<CommentEntity> call(CommentEntity comment) async {
    return await repository.addComment(comment);
  }
}
