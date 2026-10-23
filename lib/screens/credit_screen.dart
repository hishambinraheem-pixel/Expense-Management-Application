
import 'package:flutter/material.dart';

class Creditscreen extends StatefulWidget {
  const Creditscreen({super.key});

  @override
  State<Creditscreen> createState() => _CreditscreenState();
}

class _CreditscreenState extends State<Creditscreen> {
  final toController = TextEditingController();
  final amountController = TextEditingController();

  String creditType = 'Subscriptions';
  String planType = 'Monthly';
  DateTime selectedDate = DateTime.now();

  final List<Map<String, String>> credits = [];

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

  void saveCredit() {
    final name = toController.text.trim();
    final amount = double.tryParse(amountController.text);

    if (name.isEmpty || amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter valid details')),
      );
      return;
    }

    setState(() {
      credits.add({
        'type': creditType,
        'name': name,
        'amount': amount.toStringAsFixed(2),
        'plan': planType,
        'date':
            '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
      });

      toController.clear();
      amountController.clear();
    });
  }

  @override
  void dispose() {
    toController.dispose();
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
        title: const Text('Credit'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('CREDIT TYPE',
              style: TextStyle(fontSize: 10)),
          DropdownButtonFormField<String>(
            value: creditType,
            items: const [
              DropdownMenuItem(
                value: 'Subscriptions',
                child: Text('Subscriptions'),
              ),
              DropdownMenuItem(
                value: 'Bills',
                child: Text('Bills'),
              ),
              DropdownMenuItem(
                value: 'Shopping',
                child: Text('Shopping'),
              ),
              DropdownMenuItem(
                value: 'Other',
                child: Text('Other'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => creditType = value);
              }
            },
          ),
          const SizedBox(height: 12),
          const Text('TO', style: TextStyle(fontSize: 10)),
          TextField(
            controller: toController,
            decoration: const InputDecoration(
              hintText: 'Enter name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          const Text('DATE', style: TextStyle(fontSize: 10)),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
            ),
            trailing: const Icon(Icons.calendar_month),
            onTap: pickDate,
          ),
          const Text('PLAN TYPE', style: TextStyle(fontSize: 10)),
          DropdownButtonFormField<String>(
            value: planType,
            items: const [
              DropdownMenuItem(
                value: 'Monthly',
                child: Text('Monthly'),
              ),
              DropdownMenuItem(
                value: 'One-Time',
                child: Text('One-Time'),
              ),
              DropdownMenuItem(
                value: 'Yearly',
                child: Text('Yearly'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => planType = value);
              }
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: amountController,
            keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Amount',
              prefixText: '₹ ',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: saveCredit,
              style: ElevatedButton.styleFrom(
                backgroundColor: teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Save'),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Your Saved Lists',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          if (credits.isEmpty)
            const Text(
              'No saved credits yet',
              style: TextStyle(color: Colors.grey),
            ),
          ...credits.map(
            (credit) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(credit['name']!),
              subtitle: Text(
                '${credit['type']} • ${credit['plan']} • ${credit['date']}',
              ),
              trailing: Text('₹ ${credit['amount']}'),
            ),
          ),
        ],
      ),
    );
  }
}
