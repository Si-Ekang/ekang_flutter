import 'package:ekang_flutter/features/notifications/data/model/feature_item.dart';

class WhatsNewModel {
  final String version;
  final DateTime releaseDate;
  final List<FeatureItem> features;

  WhatsNewModel({
    required this.version,
    required this.releaseDate,
    required this.features,
  });


  @override
  String toString() {
    return 'WhatsNewModel{version: $version, releaseDate: $releaseDate, features: $features}';
  }

  factory WhatsNewModel.fromJson(Map<String, dynamic> json) {
    return WhatsNewModel(
      version: json['version'],
      releaseDate: DateTime.parse(json['release_date']),
      features: (json['features'] as List)
          .map((item) => FeatureItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'version': version,
      'release_date': releaseDate.toIso8601String(),
      'features': features.map((f) => f.toJson()).toList(),
    };
  }
}
