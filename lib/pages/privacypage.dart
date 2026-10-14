import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Privacy Policy"),
        centerTitle: true,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          const Icon(
            Icons.privacy_tip_outlined,
            size: 70,
          ),

          const SizedBox(height: 15),

          const Center(
            child: Text(
              "Privacy Policy",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "Your Privacy",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "We respect your privacy and are committed to "
                "protecting your personal information while using "
                "our doctor appointment application.",
          ),

          const SizedBox(height: 20),

          const Text(
            "Information We Collect",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "We may collect your name, email address, phone number "
                "and appointment information when you use our application.",
          ),

          const SizedBox(height: 20),

          const Text(
            "How We Use Your Information",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Your information is used to provide services such as "
                "user login, doctor search, appointment booking and "
                "managing your profile.",
          ),

          const SizedBox(height: 20),

          const Text(
            "Data Security",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "We take reasonable steps to protect your personal "
                "information and keep your account information secure.",
          ),

          const SizedBox(height: 20),

          const Text(
            "Third-Party Services",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Our application may use services such as Firebase "
                "for authentication and storing application data.",
          ),

          const SizedBox(height: 20),

          const Text(
            "Changes to This Policy",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "This Privacy Policy may be updated from time to time. "
                "Any changes will be reflected on this page.",
          ),

          const SizedBox(height: 25),

          Center(
            child: Text(
              "Last updated: 2026",
              style: TextStyle(
                color: Colors.grey.shade600,
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