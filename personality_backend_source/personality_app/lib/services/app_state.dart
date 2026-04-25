import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/personality_model.dart';
import 'personality_service.dart';

class AppState extends ChangeNotifier {
  DateTime? _selectedDate;
  String? _selectedGender;
  PersonalityProfile? _currentProfile;
  List<ChatMessage> _chatMessages = [];
  bool _isPremium = false;
  late SharedPreferences _prefs;
  late PersonalityService _personalityService;

  DateTime? get selectedDate => _selectedDate;
  String? get selectedGender => _selectedGender;
  PersonalityProfile? get currentProfile => _currentProfile;
  List<ChatMessage> get chatMessages => _chatMessages;
  bool get isPremium => _isPremium;

  AppState() {
    _init();
  }

  Future<void> _init() async {
    _prefs = await SharedPreferences.getInstance();
    _personalityService = PersonalityService();
    await _personalityService.loadPersonalities();
    _loadPremiumStatus();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void setSelectedGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  Future<void> analyzePersonality() async {
    if (_selectedDate == null || _selectedGender == null) return;

    _currentProfile = _personalityService.getPersonalityProfile(
      _selectedDate!,
      _selectedGender!,
    );

    // Save analysis to preferences
    await _prefs.setString('lastAnalysisDate', _selectedDate!.toIso8601String());
    await _prefs.setString('lastAnalysisGender', _selectedGender!);

    notifyListeners();
  }

  void addChatMessage(ChatMessage message) {
    _chatMessages.add(message);
    notifyListeners();
  }

  void clearChatMessages() {
    _chatMessages.clear();
    notifyListeners();
  }

  Future<void> setPremiumStatus(bool isPremium) async {
    _isPremium = isPremium;
    await _prefs.setBool('isPremium', isPremium);
    notifyListeners();
  }

  Future<void> _loadPremiumStatus() async {
    _isPremium = _prefs.getBool('isPremium') ?? false;
    notifyListeners();
  }

  void reset() {
    _selectedDate = null;
    _selectedGender = null;
    _currentProfile = null;
    _chatMessages = [];
    notifyListeners();
  }
}
