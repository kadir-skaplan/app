import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/models.dart';

class ApiService {
  // IMPORTANT: In production, use environment variables or secure storage
  // Never hardcode API keys in production apps
  static const String _baseUrl = 'http://localhost:3000';
  // For real deployment, replace with your server URL
  // static const String _baseUrl = 'https://your-api-domain.com';

  Future<Personality> analyzePersonality({
    required int day,
    required int month,
    required String gender,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/analyze'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'day': day,
          'month': month,
          'gender': gender,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Personality.fromJson(data['personality']);
      } else {
        throw Exception('Failed to analyze personality');
      }
    } catch (e) {
      // Return mock data for demo purposes when backend is unavailable
      return _getMockPersonality(month, gender);
    }
  }

  Future<AIResponse> getChatResponse({
    required String message,
    String? personalityType,
    List<String>? topics,
    String? turnOff,
    String? lastMessage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'personalityType': personalityType,
          'topics': topics,
          'turnOff': turnOff,
          'lastMessage': lastMessage,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AIResponse.fromJson(data);
      } else {
        throw Exception('Failed to get AI response');
      }
    } catch (e) {
      return _getMockAIResponse(message);
    }
  }

  Future<AIResponse> optimizeMessage({
    required String originalMessage,
    String? personalityType,
    String? goal,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/optimize'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'originalMessage': originalMessage,
          'personalityType': personalityType,
          'goal': goal,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return AIResponse.fromJson(data);
      } else {
        throw Exception('Failed to optimize message');
      }
    } catch (e) {
      return _getMockAIResponse('optimize');
    }
  }

  Future<List<Video>> getVideos() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/videos'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final videosJson = data['videos'] as List;
        return videosJson.map((v) => Video.fromJson(v)).toList();
      } else {
        throw Exception('Failed to load videos');
      }
    } catch (e) {
      return _getMockVideos();
    }
  }

  // Mock data for demo when backend is unavailable
  Personality _getMockPersonality(int month, String gender) {
    return Personality(
      type: gender.toLowerCase() == 'male' 
          ? 'The Visionary Leader' 
          : 'The Ambitious Queen',
      turnOff: 'Dishonesty and lack of ambition',
      topics: ['Career goals', 'Future plans', 'Leadership experiences'],
      outfit: 'Sharp, professional attire with bold colors',
      bodyParts: 'Strong jawline, confident posture',
      caseStudy: 'This person commands attention without saying a word...',
      datingIdeas: 'Exclusive rooftop dinner, private art gallery tour',
      presents: 'Luxury watch, personalized leather goods',
      keepSpark: 'Challenge them intellectually, show your own ambitions',
      afterBreakup: 'Give space, then reconnect with something impressive',
      key: '${_getMonthName(month)}_${gender.toLowerCase()}',
    );
  }

  String _getMonthName(int month) {
    const months = ['january', 'february', 'march', 'april', 'may', 'june',
                    'july', 'august', 'september', 'october', 'november', 'december'];
    return months[month - 1];
  }

  AIResponse _getMockAIResponse(String message) {
    return AIResponse(
      response: 'Here are some suggestions for you...',
      options: [
        '"Hey! Been thinking about you 😊"',
        '"Random thought: you\'d love this place I found..."',
        '"Quick question for you..."',
      ],
    );
  }

  List<Video> _getMockVideos() {
    return [
      Video(
        id: 'v1',
        title: 'If his birthday is June… watch this',
        thumbnail: 'assets/images/thumb1.jpg',
        url: 'assets/videos/video1.mp4',
        isFree: true,
        duration: '0:59',
      ),
      Video(
        id: 'v2',
        title: 'Never do this to this type',
        thumbnail: 'assets/images/thumb2.jpg',
        url: 'assets/videos/video2.mp4',
        isFree: false,
        duration: '1:23',
      ),
      Video(
        id: 'v3',
        title: 'The secret attraction trigger',
        thumbnail: 'assets/images/thumb3.jpg',
        url: 'assets/videos/video3.mp4',
        isFree: false,
        duration: '0:47',
      ),
    ];
  }
}
