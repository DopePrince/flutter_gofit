import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/instructor/jadwal_instructor.dart';
import 'package:flutter_application_1/page/instructor/instructor_izin.dart';
import 'package:flutter_application_1/page/instructor/instructor_profile.dart';

class InstructorHomePage extends StatefulWidget {
  final Map<String, dynamic> currentInstructor;

  const InstructorHomePage({Key? key, required this.currentInstructor})
      : super(key: key);

  @override
  _InstructorHomePageState createState() => _InstructorHomePageState();
}

class _InstructorHomePageState extends State<InstructorHomePage> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      const JadwalInstructorPage(),
      const InstructorIzinPage(),
      InstructorProfilePage(instructor: widget.currentInstructor),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instructor Home'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Class Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
