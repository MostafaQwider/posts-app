import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import '../../features/posts/data/datasources/post_local_data_source.dart';
import '../../features/posts/data/datasources/post_remote_data_source.dart';
import '../../features/posts/data/repositories_impl/post_repository_impl.dart';
import '../../features/posts/domain/repositories/post_repository.dart';
import '../../features/posts/domain/usecases/add_comment_usecase.dart';
import '../../features/posts/domain/usecases/add_post_usecase.dart';
import '../../features/posts/domain/usecases/delete_post_usecase.dart';
import '../../features/posts/domain/usecases/get_comments_usecase.dart';
import '../../features/posts/domain/usecases/get_all_comments_usecase.dart';
import '../../features/posts/domain/usecases/get_posts_usecase.dart';
import '../../features/posts/domain/usecases/update_post_usecase.dart';
import '../../features/posts/presentation/providers/post_provider.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  //! Features - Posts
  // Provider
  sl.registerFactory(
    () => PostProvider(
      getPostsUseCase: sl(),
      addPostUseCase: sl(),
      getCommentsUseCase: sl(),
      addCommentUseCase: sl(),
      deletePostUseCase: sl(),
      getAllCommentsUseCase: sl(),
      updatePostUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => GetCommentsUseCase(sl()));
  sl.registerLazySingleton(() => GetAllCommentsUseCase(sl()));
  sl.registerLazySingleton(() => AddCommentUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  // Repository
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data Sources
  sl.registerLazySingleton(() => PostRemoteDataSource(firestore: sl()));
  sl.registerLazySingleton(() => PostLocalDataSource(storageService: sl()));

  //! Core

  sl.registerLazySingleton(() => ApiService());
  sl.registerLazySingleton(() => StorageService());

  //! External
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
