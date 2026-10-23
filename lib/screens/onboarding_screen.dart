import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/bottomnavigatiobn.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF8),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Expanded(
              child: Image.asset(
                'lib/screens/assets/opening image.png',
                fit: BoxFit.contain,
              ),
            ),
            const Text(
              'Spend Smarter\nSave More',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF388780),
              ),
            ),

            const SizedBox(height: 20),

            // Get Started button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Bottombar(),));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF55AAA2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Get Started'),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}