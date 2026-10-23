
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/hive_services.dart';
import 'package:flutter_application_1/screens/models/transaction_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final hiveservice = Hiveservice();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: ValueListenableBuilder<Box<TransactionModel>>(
          valueListenable: hiveservice.box.listenable(),
          builder: (context, box, child) {
            final transactions = box.values.toList().reversed.toList();

            double income = 0;
            double expenses = 0;

            for (var transaction in transactions) {
              if (transaction.type.toLowerCase() == 'income') {
                income += transaction.amount;
              } else {
                expenses += transaction.amount;
              }
            }

            double balance = income - expenses;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good afternoon,',
                    style: TextStyle(fontSize: 13),
                  ),
                  const Text(
                    'muhammed hisham',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF388780),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Balance',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          '₹ ${balance.toStringAsFixed(2)}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Income',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '₹ ${income.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Expenses',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '₹ ${expenses.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: _averageCard('DAILY AVERAGE', '₹0.00'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _averageCard('WEEKLY', '₹0.00'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Transactions History',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Expanded(
                    child: transactions.isEmpty
                        ? const Center(
                            child: Text('No transactions yet'),
                          )
                        : ListView.builder(
                            itemCount: transactions.length > 5
                                ? 5
                                : transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              final isIncome = transaction.type
                                      .toLowerCase() ==
                                  'income';

                              return _transaction(
                                transaction.title,
                                transaction.date,
                                '${isIncome ? '+' : '-'} ₹${transaction.amount.toStringAsFixed(2)}',
                                isIncome,
                              );
                            },
                          ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

    );
  }

  Widget _averageCard(String title, String amount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            amount,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          )
        ),
      ],
    );
  }

  Widget _transaction(
    String name,
    String date,
    String amount,
    bool income,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: income
                  ? const Color(0xFF00B96B)
                  : Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
