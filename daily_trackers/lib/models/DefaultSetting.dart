class DefaultSetting {
  int? id;
  String key;
  String? value;

  DefaultSetting({
    this.id,
    required this.key,
    this.value,
  });

  // Convert a map to a DefaultSetting object
  factory DefaultSetting.fromMap(Map<String, dynamic> map) {
    return DefaultSetting(
      id: map['id'],
      key: map['key'],
      value: map['value'],
    );
  }

  // Convert a DefaultSetting object to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'key': key,
      'value': value,
    };
  }
}
