import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/personality_model.dart';

class PersonalityService {
  static final PersonalityService _instance = PersonalityService._internal();

  factory PersonalityService() {
    return _instance;
  }

  PersonalityService._internal();

  late List<PersonalityProfile> _personalities = [];

  Future<void> loadPersonalities() async {
    final String response =
        await rootBundle.loadString('assets/data/personalities.json');
    final data = json.decode(response);
    _personalities = (data['personalities'] as List)
        .map((p) => PersonalityProfile.fromJson(p))
        .toList();
  }

  PersonalityProfile? getPersonalityProfile(
      DateTime birthDate, String gender) {
    final month = birthDate.month;
    final personalityType = _getPersonalityTypeByMonth(month);
    
    final profile = _personalities.firstWhere(
      (p) => p.type == personalityType && p.gender == gender,
      orElse: () => _personalities.first,
    );
    
    return profile;
  }

  String _getPersonalityTypeByMonth(int month) {
    const types = [
      'The Protector',      // January
      'The Intellectual',   // February
      'The Adventurer',     // March
      'The Romantic',       // April
      'The Leader',         // May
      'The Creative',       // June
      'The Protector',      // July
      'The Intellectual',   // August
      'The Adventurer',     // September
      'The Romantic',       // October
      'The Leader',         // November
      'The Creative',       // December
    ];
    return types[month - 1];
  }

  List<PersonalityVideo> getVideosForPersonality(String personalityType) {
    return [
      PersonalityVideo(
        id: '1',
        title: 'If their birthday is ${personalityType.split(' ').last}… watch this',
        videoUrl: 'https://example.com/video1.mp4',
        thumbnailUrl: 'https://via.placeholder.com/300x500?text=Video+1',
        isPremium: false,
        personalityType: personalityType,
      ),
      PersonalityVideo(
        id: '2',
        title: 'Never do this to ${personalityType.split(' ').last}',
        videoUrl: 'https://example.com/video2.mp4',
        thumbnailUrl: 'https://via.placeholder.com/300x500?text=Video+2',
        isPremium: true,
        personalityType: personalityType,
      ),
      PersonalityVideo(
        id: '3',
        title: 'How to attract ${personalityType.split(' ').last}',
        videoUrl: 'https://example.com/video3.mp4',
        thumbnailUrl: 'https://via.placeholder.com/300x500?text=Video+3',
        isPremium: true,
        personalityType: personalityType,
      ),
    ];
  }
}
