import 'package:flutter/material.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class AppProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  UserProfile? _userProfile;
  Personality? _personality;
  List<Video> _videos = [];
  bool _isPremium = false;
  bool _isLoading = false;
  String? _error;

  // Getters
  UserProfile? get userProfile => _userProfile;
  Personality? get personality => _personality;
  List<Video> get videos => _videos;
  bool get isPremium => _isPremium;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasAnalysis => _personality != null;

  // Analyze personality
  Future<void> analyzePersonality({
    required int day,
    required int month,
    required String gender,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _userProfile = UserProfile(
        day: day,
        month: month,
        gender: gender,
        birthDate: DateTime(2000, month, day),
      );
      
      _personality = await _apiService.analyzePersonality(
        day: day,
        month: month,
        gender: gender,
      );
      
      _videos = await _apiService.getVideos();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get AI chat response
  Future<List<String>> getChatResponse({
    required String message,
    List<String>? topics,
    String? turnOff,
  }) async {
    try {
      final response = await _apiService.getChatResponse(
        message: message,
        personalityType: _personality?.type,
        topics: topics ?? _personality?.topics,
        turnOff: turnOff ?? _personality?.turnOff,
      );
      return response.options;
    } catch (e) {
      return ['Sorry, unable to get response. Please try again.'];
    }
  }

  // Optimize message
  Future<List<String>> optimizeMessage({
    required String originalMessage,
    String? goal,
  }) async {
    try {
      final response = await _apiService.optimizeMessage(
        originalMessage: originalMessage,
        personalityType: _personality?.type,
        goal: goal,
      );
      return response.options;
    } catch (e) {
      return ['Unable to optimize. Try rephrasing.'];
    }
  }

  // Toggle premium (in real app, this would be after payment)
  void togglePremium() {
    _isPremium = !_isPremium;
    notifyListeners();
  }

  // Reset analysis
  void resetAnalysis() {
    _userProfile = null;
    _personality = null;
    _error = null;
    notifyListeners();
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
