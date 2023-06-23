import 'package:flutter/material.dart';

class ClassBookingPage extends StatelessWidget {
  const ClassBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Booking'),
      ),
      body: const Center(
        child: Text('Class Booking Page'),
      ),
    );
  }
}