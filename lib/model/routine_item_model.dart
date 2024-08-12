class RoutineItemModel {
  final String name;
  final String description;
  bool isDone;
  final String imagePath;
  final DateTime? timestamp;

  RoutineItemModel({
    required this.name,
    required this.description,
    required this.isDone,
    required this.imagePath,
    this.timestamp,
  });

  factory RoutineItemModel.fromJson(Map<String, dynamic> json) {
    return RoutineItemModel(
      name: json['name'] as String,
      description: json['description'] as String,
      isDone: json['isDone'] as bool,
      imagePath: json['imagePath'] as String,
      // timestamp: DateTime.parse(json['timestamp']),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'isDone': isDone,
      'imagePath': imagePath,
      'timestamp': timestamp!.toIso8601String(),
    };
  }
}
