
import 'package:flutter/material.dart';
import 'models/transaction_model.dart';
import '../services/hive_services.dart';

class Edittransactionscreen extends StatefulWidget {
  final dynamic transactionKey;
  final TransactionModel transaction;

  const Edittransactionscreen({
    super.key,
    required this.transactionKey,
    required this.transaction,
  });

  @override
  State<Edittransactionscreen> createState() =>
      _EdittransactionscreenState();
}

class _EdittransactionscreenState
    extends State<Edittransactionscreen> {
  final service = Hiveservice();
  late TextEditingController nameController;
  late TextEditingController amountController;

  late String type;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();

    nameController =
        TextEditingController(text: widget.transaction.title);
    amountController = TextEditingController(
      text: widget.transaction.amount.toString(),
    );
    type = widget.transaction.type;

    final parts = widget.transaction.date.split('/');
    selectedDate = parts.length == 3
        ? DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          )
        : DateTime.now();
  }

  Future<void> pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> save() async {
    final name = nameController.text.trim();
    final amount = double.tryParse(amountController.text);

    if (name.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid details')),
      );
      return;
    }

    final updated = TransactionModel(
      title: name,
      amount: amount,
      type: type,
      date:
          '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
    );

    await service.updateTransaction(
      widget.transactionKey,
      updated,
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
    const teal = Color(0xFF388780);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: teal,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Edit Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('TRANSACTION TYPE'),
                    DropdownButtonFormField<String>(
                      value: type,
                      items: const [
                        DropdownMenuItem(
                          value: 'Expense',
                          child: Text('Expense'),
                        ),
                        DropdownMenuItem(
                          value: 'Income',
                          child: Text('Income'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => type = value);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('NAME'),
                    TextField(controller: nameController),
                    const SizedBox(height: 16),
                    const Text('AMOUNT'),
                    TextField(
                      controller: amountController,
                      keyboardType:
                          const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        prefixText: '₹ ',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('DATE'),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        '${selectedDate.day}, ${selectedDate.month}, ${selectedDate.year}',
                      ),
                      trailing: const Icon(Icons.calendar_month),
                      onTap: pickDate,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: teal,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
