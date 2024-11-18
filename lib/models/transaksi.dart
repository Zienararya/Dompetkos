class TransactionModel {
  int? id, amount;
  String? date, category, desc, type;
  bool? isreminder;

  TransactionModel(
      {this.id,
      this.date,
      this.category,
      this.amount,
      this.desc,
      this.type,
      this.isreminder});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      date: json['date'],
      category: json['category'],
      amount: json['amount'],
      desc: json['desc'],
      type: json['type'],
      isreminder: json['isreminder'],
    );
  }
}
