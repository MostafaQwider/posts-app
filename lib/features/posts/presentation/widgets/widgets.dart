import 'package:flutter/material.dart';
import '../../domain/entities/post_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentTile extends StatelessWidget {
  final String name;
  final String content;
  final DateTime createdAt;

  const CommentTile({
    super.key,
    required this.name,
    required this.content,
    required this.createdAt,
  });

  String _getInitials(String name) {
    if (name.isEmpty) return "G";
    List<String> nameParts = name.trim().split(" ");
    if (nameParts.length > 1) {
      return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
    }
    return nameParts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[350]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 5,
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blueGrey[50],
                child: Text(
                  _getInitials(name),
                  style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // الاسم والوقت
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      timeago.format(createdAt),
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.more_vert, size: 18, color: Colors.grey[700]),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Assuming PostEntity is defined elsewhere, e.g.:
// class PostEntity {
//   final String? authorName;
//   final String? title;
//   final String? body;
//   PostEntity({this.authorName, this.title, this.body});
// }

class AddBottomSheet extends StatefulWidget {
  final bool isPost; // true للمنشور، false للتعليق
  final Function(Map<String, String>) onSubmit;
  final PostEntity? postToEdit;

  const AddBottomSheet(
      {super.key,
      required this.isPost,
      required this.onSubmit,
      this.postToEdit});

  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  // تعريف وحدات التحكم لكل حقل لضمان فصل البيانات
  late TextEditingController _nameController;
  late TextEditingController _titleController; // خاص بالمنشور
  late TextEditingController _emailController; // خاص بالتعليق
  late TextEditingController _contentController; // للوصف أو التعليق

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.postToEdit?.authorName ?? '');
    _titleController =
        TextEditingController(text: widget.postToEdit?.title ?? '');
    _emailController = TextEditingController();
    _contentController =
        TextEditingController(text: widget.postToEdit?.body ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _titleController.dispose();
    _emailController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.only(
            top: 15,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.isPost
                              ? (widget.postToEdit != null
                                  ? "Update Post"
                                  : "Add Post")
                              : "Add Comment",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                          widget.isPost
                              ? (widget.postToEdit != null
                                  ? "Update your story"
                                  : "Share your story")
                              : "Share your thoughts",
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              _buildLabel("Name"),
              _buildTextField(_nameController, "Your name"),
              const SizedBox(height: 15),
              _buildLabel(widget.isPost ? "Title" : "Email"),
              _buildTextField(
                widget.isPost ? _titleController : _emailController,
                widget.isPost ? "Post title" : "Email address",
              ),
              const SizedBox(height: 15),
              _buildLabel(widget.isPost ? "Description" : "Comment"),
              _buildTextField(
                _contentController,
                "Type here...",
                maxLines: 3,
                hasBorder: true,
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        side: BorderSide(color: Colors.grey.shade300),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Cancel",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _handleSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(widget.isPost
                          ? (widget.postToEdit != null
                              ? "Save Changes"
                              : "Publish")
                          : "Comment"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
    bool hasBorder = false,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: hasBorder
              ? BorderSide(color: Colors.grey.shade400)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
              color: hasBorder
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_nameController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in the required fields")),
      );
      return;
    }

    final Map<String, String> data = {
      'name': _nameController.text,
      'content': _contentController.text,
    };

    if (widget.isPost) {
      data['title'] = _titleController.text;
    } else {
      data['email'] = _emailController.text;
    }

    widget.onSubmit(data);
    Navigator.pop(context);
  }
}
