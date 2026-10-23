
import 'package:hive/hive.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: 0)
class TransactionModel {
  @HiveField(0)
  String title;

  @HiveField(1)
  double amount;

  @HiveField(2)
  String type;

  @HiveField(3)
  String date;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
  });
}
