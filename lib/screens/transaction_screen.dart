
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/models/transaction_model.dart';
import 'package:flutter_application_1/services/hive_services.dart';
import 'package:hive_flutter/hive_flutter.dart';


class Transactionscreen extends StatelessWidget {
  const Transactionscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hiveservice=Hiveservice();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF388780),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Transaction History'),
      ),
      body: ValueListenableBuilder<Box<TransactionModel>>(
        valueListenable: hiveservice.box.listenable(),
        builder: (context, box, child) {
          final keys = box.keys.toList().reversed.toList();

          if (keys.isEmpty) {
            return const Center(
              child: Text('No transactions yet'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final key = keys[index];
              final transaction = box.get(key);

              if (transaction == null) {
                return const SizedBox.shrink();
              }

              final isIncome = transaction.type == 'Income';

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            transaction.date,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${isIncome ? '+' : '-'} ₹${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: isIncome
                            ? const Color(0xFF00B96B)
                            : Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Edit feature will be added next'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit, size: 18),
                    ),
                    IconButton(
                      onPressed: () async {
                        await hiveservice.deleteTransaction(key);
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
