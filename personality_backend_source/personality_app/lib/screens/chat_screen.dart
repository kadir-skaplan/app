import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/personality_model.dart';
import '../services/app_state.dart';
import '../services/api_service.dart';
import '../widgets/chat_bubble.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ApiService _apiService = ApiService();
  bool _isLoading = false;

  final List<Map<String, String>> _quickButtons = [
    {'label': 'Write first message', 'prompt': 'How should I write my first message?'},
    {'label': 'What should I say next?', 'prompt': 'What should I say next to keep the conversation going?'},
    {'label': 'Why are they distant?', 'prompt': 'Why might they be acting distant?'},
    {'label': 'How to attract?', 'prompt': 'How can I attract them more?'},
  ];

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() {
    final appState = context.read<AppState>();
    if (appState.chatMessages.isEmpty) {
      appState.addChatMessage(
        ChatMessage(
          id: const Uuid().v4(),
          content:
              'I already analyzed this personality type. What do you want to do next?',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    }
  }

  void _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    final appState = context.read<AppState>();
    final profile = appState.currentProfile;

    if (profile == null) return;

    // Add user message
    appState.addChatMessage(
      ChatMessage(
        id: const Uuid().v4(),
        content: message,
        isUser: true,
        timestamp: DateTime.now(),
      ),
    );

    _messageController.clear();
    _scrollToBottom();

    setState(() => _isLoading = true);

    try {
      final response = await _apiService.chatWithAI(message, profile.type);

      if (!response.containsKey('error')) {
        final aiResponse = response['response'] ?? 'I understand. Tell me more.';
        appState.addChatMessage(
          ChatMessage(
            id: const Uuid().v4(),
            content: aiResponse,
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      } else {
        appState.addChatMessage(
          ChatMessage(
            id: const Uuid().v4(),
            content:
                'I understand. Tell me more about what you\'re experiencing.',
            isUser: false,
            timestamp: DateTime.now(),
          ),
        );
      }
    } catch (e) {
      appState.addChatMessage(
        ChatMessage(
          id: const Uuid().v4(),
          content: 'I\'m here to help. What would you like to know?',
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
    }

    setState(() => _isLoading = false);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
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
      appBar: AppBar(
        backgroundColor: Color(0xFF1a1a2e),
        elevation: 0,
        title: Text(
          'AI Personality Coach',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF00d4ff)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
            ],
          ),
        ),
        child: Column(
          children: [
            // Messages
            Expanded(
              child: Consumer<AppState>(
                builder: (context, appState, _) {
                  return ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16),
                    itemCount: appState.chatMessages.length,
                    itemBuilder: (context, index) {
                      final message = appState.chatMessages[index];
                      return ChatBubble(
                        message: message,
                        isPremium: appState.isPremium,
                      );
                    },
                  );
                },
              ),
            ),

            // Quick Buttons (if no messages sent yet)
            Consumer<AppState>(
              builder: (context, appState, _) {
                if (appState.chatMessages.length <= 1) {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Questions',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _quickButtons
                              .map(
                                (btn) => GestureDetector(
                                  onTap: () => _sendMessage(btn['prompt']!),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0f3460),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Color(0xFF00d4ff),
                                      ),
                                    ),
                                    child: Text(
                                      btn['label']!,
                                      style: TextStyle(
                                        color: Color(0xFF00d4ff),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            ),

            // Input Area
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF0f3460),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey[700]!,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Ask me anything...',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      enabled: !_isLoading,
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: _isLoading
                        ? null
                        : () => _sendMessage(_messageController.text),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: _isLoading
                            ? Colors.grey[700]
                            : Color(0xFF00d4ff),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF1a1a2e),
                                ),
                              ),
                            )
                          : Icon(
                              Icons.send,
                              color: Color(0xFF1a1a2e),
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
    );
  }
}
