import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../services/app_state.dart';
import '../models/personality_model.dart';
import '../utils/theme.dart';
import '../widgets/animated_particles.dart';
import '../widgets/chat_bubble.dart';

class ChatScreenNew extends StatefulWidget {
  const ChatScreenNew({Key? key}) : super(key: key);

  @override
  State<ChatScreenNew> createState() => _ChatScreenNewState();
}

class _ChatScreenNewState extends State<ChatScreenNew> {
  late TextEditingController _messageController;
  late ScrollController _scrollController;
  final _uuid = const Uuid();

  final List<String> _quickQuestions = [
    'How should I approach them?',
    'What do they value most?',
    'How to make them laugh?',
  ];

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: Stack(
          children: [
            // Animated Particles Background
            Positioned.fill(
              child: AnimatedParticles(
                particleCount: 20,
                color: Colors.white,
                maxSize: 2.0,
              ),
            ),

            // Gradient Blobs
            Positioned(
              left: -50,
              top: 50,
              child: GradientBlob(
                color: const Color(0xFF9F7AEA).withOpacity(0.3),
                size: 200,
                position: const Offset(0, 0),
                duration: const Duration(seconds: 6),
              ),
            ),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white.withOpacity(0.08),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                              ),
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                        Text(
                          'AI Assistant',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                        ),
                      ],
                    ),
                  ),

                  // Chat Messages
                  Expanded(
                    child: Consumer<AppState>(
                      builder: (context, appState, _) {
                        final messages = appState.chatMessages;
                        if (messages.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Quick Questions',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 12),
                                ...List.generate(
                                  _quickQuestions.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        _messageController.text =
                                            _quickQuestions[index];
                                        _sendMessage(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                            color: Colors.white
                                                .withOpacity(0.15),
                                            width: 1.5,
                                          ),
                                          color: Colors.white
                                              .withOpacity(0.05),
                                        ),
                                        child: Text(
                                          _quickQuestions[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.8),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: ChatBubble(
                                message: message,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Input Area
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: GlassCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            borderRadius: 12,
                            child: TextField(
                              controller: _messageController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                  ),
                              decoration: InputDecoration(
                                hintText: 'Ask something...',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Colors.white.withOpacity(0.4),
                                    ),
                                border: InputBorder.none,
                              ),
                              maxLines: null,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => _sendMessage(context),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFF00D4FF),
                                  Color(0xFF0084FF),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage(BuildContext context) {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      context.read<AppState>().addChatMessage(
            ChatMessage(
              id: _uuid.v4(),
              content: text,
              isUser: true,
              timestamp: DateTime.now(),
            ),
          );
      _messageController.clear();

      // Simulate AI response
      Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          context.read<AppState>().addChatMessage(
                ChatMessage(
                  id: _uuid.v4(),
                  content:
                      'Based on their personality type, I suggest approaching them with genuine curiosity and patience. They value authentic connections above all else.',
                  isUser: false,
                  timestamp: DateTime.now(),
                ),
              );
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
          }
        }
      });
    }
  }
}
