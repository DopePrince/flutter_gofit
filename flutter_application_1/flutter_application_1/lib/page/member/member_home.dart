import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/member/jadwal_harian.dart';
import 'package:flutter_application_1/page/member/class_booking.dart';
import 'package:flutter_application_1/page/member/member_profile.dart';

class MemberHomePage extends StatefulWidget {
  final Map<String, dynamic> currentMember;

  const MemberHomePage({Key? key, required this.currentMember}) : super(key: key);

  @override
  _MemberHomePageState createState() => _MemberHomePageState();
}

class _MemberHomePageState extends State<MemberHomePage> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      const JadwalPage(),
      const ClassBookingPage(),
      MemberProfilePage(member: widget.currentMember),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Member Home'),
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
