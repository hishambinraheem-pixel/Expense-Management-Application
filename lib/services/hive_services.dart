import 'package:flutter_application_1/screens/models/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Hiveservice {
  final Box<TransactionModel> box =
      Hive.box<TransactionModel>('transactions');

  Future<void> addTransaction(
    TransactionModel transaction,
  ) async {
    await box.add(transaction);
  }

  List<TransactionModel> getTransactions() {
    return box.values.toList();
  }

  Future<void> deleteTransaction(dynamic key) async {
    await box.delete(key);
  }

  Future<void> updateTransaction(
    dynamic key,
    TransactionModel transaction,
  ) async {
    await box.put(key, transaction);
  }
}