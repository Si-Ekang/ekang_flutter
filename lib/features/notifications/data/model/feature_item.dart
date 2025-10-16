class FeatureItem {
  final String id;
  final String title;
  final String message;
  final List<String> tags;
  final String category;
  final DateTime timestamp;

  FeatureItem({
    required this.id,
    required this.title,
    required this.message,
    required this.tags,
    required this.category,
    required this.timestamp,
  });


  @override
  String toString() {
    return 'FeatureItem{id: $id, title: $title, message: $message, tags: $tags, category: $category, timestamp: $timestamp}';
  }

  factory FeatureItem.fromJson(Map<String, dynamic> json) {
    return FeatureItem(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      tags: List<String>.from(json['tags']),
      category: json['category'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'tags': tags,
      'category': category,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
