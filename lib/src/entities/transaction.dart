import "budget.dart";
import "tag.dart";
import "transaction_split.dart";

class Transaction {
  Transaction({
    required this.id,
    required this.name,
    required this.description,
    required this.budget,
    required this.value,
    required this.createdAt,
    required this.tags,
    required this.splits,
  })  : assert(
          splits.map((e) => e.percentage).reduce((a, b) => a + b) == 1,
          "splits percentage must sum up to 1 (100% of a transaction value)",
        ),
        assert(description == null || description.isNotEmpty);

  final String id;
  final String name;
  final String? description;
  final Budget budget;
  final int value;
  final DateTime createdAt;
  final List<Tag> tags;
  final List<TransactionSplit> splits;
}
