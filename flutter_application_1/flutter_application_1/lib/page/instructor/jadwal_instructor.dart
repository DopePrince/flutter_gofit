import 'package:flutter/material.dart';

class JadwalInstructorPage extends StatelessWidget {
  const JadwalInstructorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Instructor'),
      ),
      body: const Center(
        child: Text('Jadwal Instructor Hari Ini'),
      ),
    );
  }
}
