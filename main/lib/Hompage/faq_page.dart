import 'package:flutter/material.dart';

Widget faqPage() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Frequently Asked Questions',
            style: TextStyle(
              fontFamily: 'ArchivoBold',
              fontSize: 32.0,
              height: 48 / 32,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5.0),
          const Text(
            'Find answers to common questions about Waste to wealth\'s features and services.',
            style: TextStyle(
              fontFamily: 'InterRegular',
              fontSize: 14.0,
              height: 22 / 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20.0),
          // FAQ Items
          Column(  // Remove the SizedBox and height
            children: [
              _buildFAQItem(
                question: 'What is Waste to wealth?',
                answer: 'Waste to wealth is a platform designed to promote sustainable living by connecting users with eco-friendly products and services.',
              ),
              _buildFAQItem(
                question: 'How can I create an account?',
                answer: 'You can create an account by clicking on the "Sign Up" button on the homepage and filling out the required details.',
              ),
              _buildFAQItem(
                question: 'Are there any subscription fees?',
                answer: 'No, Waste to wealth is free to use. There are no subscription fees involved.',
              ),
              _buildFAQItem(
                question: 'How do I find eco-friendly products?',
                answer: 'You can browse the products section or use the search bar to find eco-friendly products and services.',
              ),
              _buildFAQItem(
                question: 'Is my data secure with Waste to wealth?',
                answer: 'Yes, Waste to wealth uses encryption and other security measures to protect your data.',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildFAQItem({required String question, required String answer}) {
  return ExpansionTile(
    title: Text(
      question,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    ),
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(
          answer,
          style: const TextStyle(fontSize: 16.0),
        ),
      ),
    ],
  );
}
