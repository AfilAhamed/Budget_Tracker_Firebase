class TotalAmountModel {
  int? totalBalance;
  int? totalCredit;
  int? totalDebit;

  TotalAmountModel({
    required this.totalBalance,
    required this.totalCredit,
    required this.totalDebit,
  });

  factory TotalAmountModel.fromJson(Map data) {
    return TotalAmountModel(
        totalBalance: data['totalBalance'],
        totalCredit: data['totalCredit'],
        totalDebit: data['totalDebit']);
  }

  Map<String, dynamic> toJson() {
    return {
      'totalBalance': totalBalance,
      'totalCredit': totalCredit,
      'totalDebit': totalDebit
    };
  }
}
