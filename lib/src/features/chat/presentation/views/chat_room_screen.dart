import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets/page_header.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final List<_Message> _messages = [
    const _Message(
      author: MessageAuthor.assistant,
      text: 'Remembers what user said earlier in the conversation and keeps tone consistent.',
    ),
    const _Message(
      author: MessageAuthor.assistant,
      text: 'Allows user to provide follow-up corrections with AI-suggested improvements.',
    ),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(author: MessageAuthor.user, text: text));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: AppPageHeader(
                title: 'BrainBox',
                subtitle: Text(
                  'Context aware assistant',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: AppColors.textSecondary),
                ),
                actions: [
                  AppIconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  AppIconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  AppIconButton(
                    icon: const Icon(Icons.more_horiz_rounded),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  return Align(
                    alignment: message.author == MessageAuthor.user
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: _MessageBubble(message: message),
                  );
                },
                itemCount: _messages.length,
              ),
            ),
            _Composer(
              controller: _controller,
              onSend: _handleSend,
            ),
          ],
        ),
      ),
    );
  }
}

enum MessageAuthor { user, assistant }

class _Message {
  const _Message({required this.author, required this.text});

  final MessageAuthor author;
  final String text;
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final _Message message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.author == MessageAuthor.user;
    final background = isUser ? AppColors.primary : Colors.white;
    final textColor = isUser ? Colors.white : AppColors.textPrimary;

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(24),
          topRight: const Radius.circular(24),
          bottomLeft: Radius.circular(isUser ? 24 : 6),
          bottomRight: Radius.circular(isUser ? 6 : 24),
        ),
        boxShadow: isUser
            ? const [
                BoxShadow(
                  color: AppColors.shadow,
                  offset: Offset(0, 12),
                  blurRadius: 24,
                ),
              ]
            : const [],
      ),
      child: Text(
        message.text,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: textColor),
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({required this.controller, required this.onSend});

  final TextEditingController controller;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 24,
                offset: Offset(0, 16),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.emoji_emotions_outlined),
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Send a message...',
                      border: InputBorder.none,
                    ),
                    minLines: 1,
                    maxLines: 4,
                  ),
                ),
                const SizedBox(width: 12),
                AppIconButton(
                  icon: const Icon(Icons.send_rounded),
                  onPressed: onSend,
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}




