import '../repositories/post_repository.dart';
import '../entities/comment_entity.dart';

class GetAllCommentsUseCase {
  final PostRepository repository;

  GetAllCommentsUseCase(this.repository);

  Future<List<CommentEntity>> call() async {
    return await repository.getAllComments();
  }
}
