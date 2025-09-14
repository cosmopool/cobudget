class TransactionSplit {
  TransactionSplit(this.userId, this.percentage)
    : assert(percentage > 0),
      assert(percentage <= 1);

  final String userId;
  final double percentage;
}
