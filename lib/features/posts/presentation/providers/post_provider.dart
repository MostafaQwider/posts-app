import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/add_post_usecase.dart';
import '../../domain/usecases/get_comments_usecase.dart';
import '../../domain/usecases/get_all_comments_usecase.dart';
import '../../domain/usecases/add_comment_usecase.dart';
import '../../domain/usecases/delete_post_usecase.dart';
import '../../domain/usecases/update_post_usecase.dart';

class PostProvider with ChangeNotifier {
  final GetPostsUseCase getPostsUseCase;
  final AddPostUseCase addPostUseCase;
  final GetCommentsUseCase getCommentsUseCase;
  final AddCommentUseCase addCommentUseCase;
  final DeletePostUseCase deletePostUseCase;
  final GetAllCommentsUseCase getAllCommentsUseCase;
  final UpdatePostUseCase updatePostUseCase;

  PostProvider({
    required this.getPostsUseCase,
    required this.addPostUseCase,
    required this.getCommentsUseCase,
    required this.addCommentUseCase,
    required this.deletePostUseCase,
    required this.getAllCommentsUseCase,
    required this.updatePostUseCase,
  });

  List<PostEntity> _posts = [];
  List<CommentEntity> _comments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PostEntity> get posts => _posts;
  List<CommentEntity> get comments => _comments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchData() async {
    await fetchPosts();
    await fetchAllComments();
  }

  Future<void> fetchPosts() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _posts = await getPostsUseCase();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchComments(String postId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final comments = await getCommentsUseCase(postId);
      _comments = [..._comments, ...comments];
      _comments = comments;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchAllComments() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _comments = await getAllCommentsUseCase();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addPost(PostEntity post) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final newPost = await addPostUseCase(post);
      _posts.insert(0, newPost);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to add post: $e";
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<CommentEntity> getPostComments(String postId) {
    final comments = _comments.where((c) => c.postId == postId).toList();
    return comments;
  }

  Future<void> deletePost(String id) async {
    try {
      await deletePostUseCase(id);
      _posts.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to delete post: $e";
      notifyListeners();
    }
  }

  Future<void> addComment(CommentEntity comment) async {
    try {
      await addCommentUseCase(comment);
      notifyListeners();
    } catch (e) {
      _errorMessage = "Failed to add comment: $e";
      notifyListeners();
    }
  }

  Future<void> updatePost(PostEntity post) async {
    try {
      await updatePostUseCase(post);
      final index = _posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        _posts[index] = post;
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = "Failed to update post: $e";
      notifyListeners();
    }
  }
}
