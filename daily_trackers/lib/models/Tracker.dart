class Tracker {
  final int? id;
  final String name;
  final String type;
  final String? goal;
  final String? frequency;

  Tracker({
    this.id,
    required this.name,
    required this.type,
    this.goal,
    this.frequency,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'goal': goal,
      'frequency': frequency,
    };
  }

  static Tracker fromMap(Map<String, Object?> map) {
    return Tracker(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: map['type'] as String,
      goal: map['goal'] as String?,
      frequency: map['frequency'] as String?,
    );
  }
}
