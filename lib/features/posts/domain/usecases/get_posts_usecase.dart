import '../repositories/post_repository.dart';
import '../entities/post_entity.dart';

class GetPostsUseCase {
  final PostRepository repository;

  GetPostsUseCase(this.repository);

  Future<List<PostEntity>> call() async {
    return await repository.getPosts();
  }
}
