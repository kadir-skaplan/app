class Personality {
  final String type;
  final String turnOff;
  final List<String> topics;
  final String outfit;
  final String bodyParts;
  final String caseStudy;
  final String? datingIdeas;
  final String? presents;
  final String? keepSpark;
  final String? afterBreakup;
  final String key;

  Personality({
    required this.type,
    required this.turnOff,
    required this.topics,
    required this.outfit,
    required this.bodyParts,
    required this.caseStudy,
    this.datingIdeas,
    this.presents,
    this.keepSpark,
    this.afterBreakup,
    required this.key,
  });

  factory Personality.fromJson(Map<String, dynamic> json) {
    return Personality(
      type: json['type'] ?? 'Unknown Type',
      turnOff: json['turn_off'] ?? '',
      topics: List<String>.from(json['topics'] ?? []),
      outfit: json['outfit'] ?? '',
      bodyParts: json['body_parts'] ?? '',
      caseStudy: json['case_study'] ?? '',
      datingIdeas: json['dating_ideas'],
      presents: json['presents'],
      keepSpark: json['keep_spark'],
      afterBreakup: json['after_breakup'],
      key: json['key'] ?? '',
    );
  }
}

class Video {
  final String id;
  final String title;
  final String thumbnail;
  final String url;
  final bool isFree;
  final String duration;

  Video({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.url,
    required this.isFree,
    required this.duration,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      url: json['url'] ?? '',
      isFree: json['isFree'] ?? false,
      duration: json['duration'] ?? '',
    );
  }
}

class UserProfile {
  final int day;
  final int month;
  final String gender;
  final DateTime birthDate;

  UserProfile({
    required this.day,
    required this.month,
    required this.gender,
    required this.birthDate,
  });
}

class AIResponse {
  final String response;
  final List<String> options;

  AIResponse({
    required this.response,
    required this.options,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      response: json['response'] ?? '',
      options: List<String>.from(json['options'] ?? []),
    );
  }
}
