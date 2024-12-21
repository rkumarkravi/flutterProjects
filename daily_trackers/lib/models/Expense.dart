class Expense {
  int? id;
  String date;
  double amount;
  String category;
  String? description;
  int trackerId;

  Expense({
    this.id,
    required this.date,
    required this.amount,
    required this.category,
    this.description,
    required this.trackerId
  });

  // Convert a map into an Expense object
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      date: map['date'],
      amount: map['amount'],
      category: map['category'],
      description: map['description'],
      trackerId: map['tracker_id'],
    );
  }

  // Convert an Expense object into a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'amount': amount,
      'category': category,
      'description': description,
      'tracker_id': trackerId
    };
  }

  @override
  String toString() {
    return 'Expense(id: $id, date: $date, amount: $amount, category: $category, description: $description, trackerId: $trackerId)';
  }
}
