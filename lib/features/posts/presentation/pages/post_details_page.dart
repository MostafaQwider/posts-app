import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../providers/post_provider.dart';
import '../widgets/widgets.dart';

class PostDetailsPage extends StatefulWidget {
  final PostEntity post;
  final List<CommentEntity> postComments;

  const PostDetailsPage(
      {super.key, required this.post, required this.postComments});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  void _showEditPostSheet(BuildContext context, PostEntity post) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AddBottomSheet(
        isPost: true,
        postToEdit: post,
        onSubmit: (data) {
          final completeUpdatedPost = PostEntity(
            id: post.id,
            title: data['title'] ?? post.title,
            body: data['content'] ?? post.body,
            authorName: data['name'] ?? post.authorName,
            authorImage: post.authorImage, // Keep original author image
            createdAt: post.createdAt,
          );

          context.read<PostProvider>().updatePost(completeUpdatedPost);
        },
      ),
    );
  }

  void _showAddCommentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => AddBottomSheet(
        isPost: false,
        onSubmit: (data) {
          final newComment = CommentEntity(
            id: '', // سيولده Firebase
            postId: widget.post.id,
            name: data['name'] ?? 'Guest',
            email: data['email'] ?? '',
            body: data['content'] ?? '',
            createdAt: DateTime.now(),
          );

          setState(() {
            widget.postComments.insert(0, newComment);
          });

          context.read<PostProvider>().addComment(newComment);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Post Details",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: 16)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black, size: 22),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.white,
              elevation: 1,
              margin: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey[350]!),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.post.authorImage,
                          imageBuilder: (context, imageProvider) =>
                              CircleAvatar(
                            radius: 20,
                            backgroundImage: imageProvider,
                          ),
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: const CircleAvatar(
                                radius: 20, backgroundColor: Colors.white),
                          ),
                          errorWidget: (context, url, error) => CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.person, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Text(
                                widget.post.authorName,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87),
                              ),
                              Text(
                                DateFormat("MMMM dd, yyyy 'at' hh:mm a")
                                    .format(widget.post.createdAt),
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: const Icon(
                                CupertinoIcons.square_pencil,
                                color: Colors.black54,
                                size: 15,
                              ),
                              onPressed: () =>
                                  _showEditPostSheet(context, widget.post),
                            ),
                            const SizedBox(width: 15),
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                              icon: Icon(
                                CupertinoIcons.delete,
                                size: 15,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                context
                                    .read<PostProvider>()
                                    .deletePost(widget.post.id);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Text(widget.post.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    const SizedBox(height: 12),
                    Text(
                      widget.post.body,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.grey, height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    const Divider(height: 1, thickness: 1),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.chat_bubble,
                            size: 18, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text(
                          "${widget.postComments.length} ${widget.postComments.length <= 1 ? 'comment' : 'comments'}",
                          style: const TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Comments", style: TextStyle(fontSize: 18)),
                  ElevatedButton(
                    onPressed: () => _showAddCommentSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Add Comment",
                        style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            ),

            // قائمة التعليقات
            if (widget.postComments.isEmpty)
              const Padding(
                padding: EdgeInsets.all(40.0),
                child: Center(
                  child: Text("No comments yet",
                      style: TextStyle(color: Colors.grey)),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: widget.postComments
                      .map((comment) => CommentTile(
                          createdAt: comment.createdAt,
                          name: comment.name,
                          content: comment.body))
                      .toList(),
                ),
              ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
