class PersonalityProfile {
  final String type;
  final String gender;
  final String description;
  final String turnOff;
  final List<String> topicsToDiscuss;
  final String outfit;
  final String bodyParts;
  final String caseStudy;
  final String visualExamples;
  final String datingIdeas;
  final String presentIdeas;
  final String keepSparkAlive;
  final String afterBreakup;

  PersonalityProfile({
    required this.type,
    required this.gender,
    required this.description,
    required this.turnOff,
    required this.topicsToDiscuss,
    required this.outfit,
    required this.bodyParts,
    required this.caseStudy,
    required this.visualExamples,
    required this.datingIdeas,
    required this.presentIdeas,
    required this.keepSparkAlive,
    required this.afterBreakup,
  });

  factory PersonalityProfile.fromJson(Map<String, dynamic> json) {
    return PersonalityProfile(
      type: json['type'] ?? '',
      gender: json['gender'] ?? '',
      description: json['description'] ?? '',
      turnOff: json['turnOff'] ?? '',
      topicsToDiscuss: List<String>.from(json['topicsToDiscuss'] ?? []),
      outfit: json['outfit'] ?? '',
      bodyParts: json['bodyParts'] ?? '',
      caseStudy: json['caseStudy'] ?? '',
      visualExamples: json['visualExamples'] ?? '',
      datingIdeas: json['datingIdeas'] ?? '',
      presentIdeas: json['presentIdeas'] ?? '',
      keepSparkAlive: json['keepSparkAlive'] ?? '',
      afterBreakup: json['afterBreakup'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'gender': gender,
      'description': description,
      'turnOff': turnOff,
      'topicsToDiscuss': topicsToDiscuss,
      'outfit': outfit,
      'bodyParts': bodyParts,
      'caseStudy': caseStudy,
      'visualExamples': visualExamples,
      'datingIdeas': datingIdeas,
      'presentIdeas': presentIdeas,
      'keepSparkAlive': keepSparkAlive,
      'afterBreakup': afterBreakup,
    };
  }
}

class PersonalityVideo {
  final String id;
  final String title;
  final String videoUrl;
  final String thumbnailUrl;
  final bool isPremium;
  final String personalityType;

  PersonalityVideo({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.isPremium,
    required this.personalityType,
  });

  factory PersonalityVideo.fromJson(Map<String, dynamic> json) {
    return PersonalityVideo(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnailUrl: json['thumbnailUrl'] ?? '',
      isPremium: json['isPremium'] ?? false,
      personalityType: json['personalityType'] ?? '',
    );
  }
}

class ChatMessage {
  final String id;
  final String content;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.content,
    required this.isUser,
    required this.timestamp,
  });
}
