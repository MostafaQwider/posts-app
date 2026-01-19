import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class PostCard extends StatelessWidget {
  final PostEntity post;
  final int commentsCount;
  final Color borderColor;
  final VoidCallback onTap;

  const PostCard({
    super.key,
    required this.post,
    required this.borderColor,
    required this.commentsCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _buildAuthorImage(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post.authorName,
                          style: const TextStyle(fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          timeago.format(post.createdAt),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.grey[700],
                  )
                ],
              ),
              const SizedBox(height: 12),
              Text(
                post.title,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                post.body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(CupertinoIcons.chat_bubble,
                      color: Colors.grey, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    commentsCount.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthorImage() {
    return CachedNetworkImage(
      imageUrl: post.authorImage,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: 20,
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        radius: 20,
        backgroundColor: Colors.grey[200],
        child: const Icon(Icons.person, color: Colors.grey),
      ),
    );
  }
}
