import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Terms & Conditions"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Icon(
            Icons.description_outlined,
            size: 70,
          ),

          const SizedBox(height: 15),

          const Center(
            child: Text(
              "Terms & Conditions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Acceptance of Terms",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "By using this application, you agree to follow "
                "these Terms & Conditions. If you do not agree "
                "with these terms, please do not use the application.",
          ),

          const SizedBox(height: 20),

          const Text(
            "Account Usage",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Users are responsible for providing accurate information "
                "when creating an account and for keeping their login "
                "information secure.",
          ),

          const SizedBox(height: 20),

          const Text(
            "Appointments",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Users can book appointments based on the available "
                "doctors, dates and time slots shown in the application. "
                "Please check the appointment details before confirming.",
          ),

          const SizedBox(height: 20),

          const Text(
            "Payments",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "If payment is required for an appointment, users must "
                "provide valid payment information and complete the "
                "payment process successfully.",
          ),

          const SizedBox(height: 20),

          const Text(
            "User Responsibilities",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Users should use the application responsibly and should "
                "not misuse the services or provide false information.",
          ),

          const SizedBox(height: 20),

          const Text(
            "Changes to Terms",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "These Terms & Conditions may be updated from time to time. "
                "Users are encouraged to review this page for any changes.",
          ),

          const SizedBox(height: 25),

          Center(
            child: Text(
              "Last updated: 2026",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}