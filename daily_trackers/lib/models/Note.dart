class Note {
  final int? id; // Nullable for new notes
  final String title;
  final String content;
  final String date; // Stored as 'YYYY-MM-DD'
  final int? trackerId; // Nullable, foreign key reference

  Note({
    this.id,
    required this.title,
    required this.content,
    required this.date,
    this.trackerId,
  });

  // Convert a Note object to a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date,
      'tracker_id': trackerId,
    };
  }

  // Create a Note object from a Map from SQLite
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
      trackerId: map['tracker_id'],
    );
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, content: $content, date: $date, trackerId: $trackerId}';
  }
}
