
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/models/transaction_model.dart';
import 'package:flutter_application_1/services/hive_services.dart';



class Addexpensescreen extends StatefulWidget {
  const Addexpensescreen({super.key});

  @override
  State<Addexpensescreen> createState() => _AddexpensescreenState();
}

class _AddexpensescreenState extends State<Addexpensescreen> {
  final hiveservice=Hiveservice();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  String type = 'Expense';
  DateTime selectedDate = DateTime.now();

  Future<void> selectDate() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  Future<void> saveExpense() async {
    if (nameController.text.trim().isEmpty ||
        amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    double? amount = double.tryParse(amountController.text);

    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid amount')),
      );
      return;
    }
await hiveservice.addTransaction(
  TransactionModel(
    title: nameController.text.trim(),
    amount: amount,
    type: type,
    date: '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
  ),
);

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFF388780),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text('TRANSACTION TYPE'),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: type,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: ['Expense', 'Income'].map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    type = value;
                  });
                }
              },
            ),

            const SizedBox(height: 20),
            const Text('NAME'),
            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Enter name',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const Text('AMOUNT'),
            const SizedBox(height: 8),

            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter amount',
                prefixText: '₹ ',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const Text('DATE'),
            const SizedBox(height: 8),

            InkWell(
              onTap: selectDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_month),
                ),
                child: Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: saveExpense,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF388780),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
