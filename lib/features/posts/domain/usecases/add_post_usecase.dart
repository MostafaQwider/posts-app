import '../repositories/post_repository.dart';
import '../entities/post_entity.dart';

class AddPostUseCase {
  final PostRepository repository;

  AddPostUseCase(this.repository);

  Future<PostEntity> call(PostEntity post) async {
    return await repository.addPost(post);
  }
}
