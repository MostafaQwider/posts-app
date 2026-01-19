import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/post_provider.dart';
import '../widgets/widgets.dart';
import '../widgets/post_card.dart';
import '../../domain/entities/post_entity.dart';
import 'post_details_page.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().fetchData();
    });
  }

  void _showAddPostSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => AddBottomSheet(
        isPost: true,
        onSubmit: (data) {
          int randomId = Random().nextInt(20) + 1;
          String randomImageUrl =
              "https://randomuser.me/api/portraits/men/$randomId.jpg";

          final newPost = PostEntity(
            id: '',
            title: data['title'] ?? 'New Post',
            body: data['content'] ?? '',
            authorName: data['name'] ?? 'Me',
            authorImage: randomImageUrl,
            createdAt: DateTime.now(),
          );
          context.read<PostProvider>().addPost(newPost);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
        title: Consumer<PostProvider>(
          builder: (context, state, _) => RichText(
            text: TextSpan(
              text: 'Posts',
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(
                  text: '\n${state.posts.length} posts',
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.arrow_2_circlepath,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () => context.read<PostProvider>().fetchData(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddPostSheet(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Consumer<PostProvider>(
        builder: (context, state, child) {
          if (state.isLoading) {
            return _buildShimmerLoading();
          }

          return _buildBodyContent(state);
        },
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, index) => const PostCardSkeleton(),
    );
  }

  Widget _buildBodyContent(PostProvider state) {
    if (state.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(state.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).primaryColor)),
        ),
      );
    }

    if (state.posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.post_add_rounded,
                size: 80, color: Colors.grey.withOpacity(0.5)),
            const SizedBox(height: 16),
            const Text("لا يوجد منشورات حالياً",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("انقر على زر التحديث أو أضف منشوراً جديداً!",
                style: TextStyle(color: Colors.grey[400])),
          ],
        ),
      );
    }

    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              if (width > 680) {
                // Tablet/Web: GridView
                int crossAxisCount = width > 900 ? 3 : 2;
                return GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.5, // Adjust aspect ratio as needed
                  ),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return PostCard(
                      borderColor: index != 0
                          ? Colors.grey[350]!
                          : Theme.of(context).primaryColor,
                      commentsCount: state.getPostComments(post.id).length,
                      post: post,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PostDetailsPage(
                              post: post,
                              postComments: state.getPostComments(post.id),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                // Mobile: ListView
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    final post = state.posts[index];
                    return PostCard(
                      borderColor: index != 0
                          ? Colors.grey[350]!
                          : Theme.of(context).primaryColor,
                      commentsCount: state.getPostComments(post.id).length,
                      post: post,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PostDetailsPage(
                              post: post,
                              postComments: state.getPostComments(post.id),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class PostCardSkeleton extends StatelessWidget {
  const PostCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 20, backgroundColor: Colors.white),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(width: 100, height: 12, color: Colors.white),
                    const SizedBox(height: 6),
                    Container(width: 60, height: 10, color: Colors.white),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(width: double.infinity, height: 16, color: Colors.white),
            const SizedBox(height: 8),
            Container(width: double.infinity, height: 12, color: Colors.white),
            const SizedBox(height: 4),
            Container(width: 200, height: 12, color: Colors.white),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(width: 40, height: 12, color: Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}
