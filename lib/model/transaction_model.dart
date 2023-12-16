class TransactionModel {
  String? id;
  String? title;
  String? amount;
  String? category;
  String? dropdownValue;
  String? dates;
  int? totalBalance;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.dropdownValue,
    required this.dates,
    required this.totalBalance,
  });

  factory TransactionModel.fromJson(Map data, id) {
    return TransactionModel(
        id: id,
        title: data['title'],
        amount: data['amount'],
        totalBalance: data['totalBalance'],
        category: data['category'],
        dropdownValue: data['dropDownValue'],
        dates: data['Date']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'Date': dates,
      'category': category,
      'dropDownValue': dropdownValue,
      'totalBalance': totalBalance,
    };
  }
}
