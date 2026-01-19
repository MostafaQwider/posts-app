import '../repositories/post_repository.dart';

class DeletePostUseCase {
  final PostRepository repository;

  DeletePostUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deletePost(id);
  }
}
