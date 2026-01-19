import '../repositories/post_repository.dart';
import '../entities/post_entity.dart';

class UpdatePostUseCase {
  final PostRepository repository;

  UpdatePostUseCase(this.repository);

  Future<void> call(PostEntity post) async {
    return await repository.updatePost(post);
  }
}
