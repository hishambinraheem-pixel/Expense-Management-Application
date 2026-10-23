import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/add_expense.dart';
import 'package:flutter_application_1/screens/credit_screen.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';
import 'package:flutter_application_1/screens/transaction_screen.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({super.key});

  @override
  State<Bottombar> createState() => _BottombarState();
}

class _BottombarState extends State<Bottombar> {
  int index = 0;

  final pages = const [
    Homescreen(),
    Transactionscreen(),
    Creditscreen(),
    Profilescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF388780),
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() => index = 0);
              },
              icon: Icon(
                Icons.home_outlined,
                color: index == 0 ? Colors.white : Colors.white54,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() => index = 1);
              },
              icon: Icon(
                Icons.history,
                color: index == 1 ? Colors.white : Colors.white54,
              ),
            ),
            const SizedBox(width: 40),
            IconButton(
              onPressed: () {
                setState(() => index = 2);
              },
              icon: Icon(
                Icons.account_balance_wallet_outlined,
                color: index == 2 ? Colors.white : Colors.white54,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() => index = 3);
              },
              icon: Icon(
                Icons.person_outline,
                color: index == 3 ? Colors.white : Colors.white54,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Addexpensescreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF388780),
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}