class MilkDelivery {
  int? id;
  String date;
  double quantity;
  double price;
  String? milkmanName;
  int? trackerId;

  MilkDelivery({
    this.id,
    required this.date,
    required this.quantity,
    required this.price,
    this.milkmanName,
    this.trackerId,
  });

  // Convert a MilkDelivery into a Map object for SQFlite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'quantity': quantity,
      'price': price,
      'milkman_name': milkmanName,
      'tracker_id': trackerId,
    };
  }

  // Convert a Map into a MilkDelivery object
  factory MilkDelivery.fromMap(Map<String, dynamic> map) {
    return MilkDelivery(
      id: map['id'],
      date: map['date'],
      quantity: map['quantity'],
      price: map['price'],
      milkmanName: map['milkman_name'],
      trackerId: map['tracker_id'],
    );
  }
}
