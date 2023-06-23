import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_application_1/page/login.dart'; // Import the LoginPage

class InstructorProfilePage extends StatefulWidget {
  final Map<String, dynamic> instructor;

  const InstructorProfilePage({Key? key, required this.instructor})
      : super(key: key);

  @override
  _InstructorProfilePageState createState() => _InstructorProfilePageState();
}

class _InstructorProfilePageState extends State<InstructorProfilePage> {
  Map<String, dynamic> profileData = {};

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final apiUrl =
        'http://192.168.26.78:8000/api/instructor/${widget.instructor['ID_INSTRUCTOR']}';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      setState(() {
        profileData = responseData['data'] as Map<String, dynamic>;
      });
    } else {
      throw Exception('Failed to fetch profile data');
    }
  }

  Widget buildInstructorProfile() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Center(
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50.0,
                child: ClipOval(
                  child: Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/08/28/13/29/avatar-3637561_1280.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: ListTile(
                  title: Text(
                    profileData['FULL_NAME'],
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: ListTile(
                  title: Text(
                    profileData['ID_INSTRUCTOR'],
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Card(
          child: Column(
            children: [
              const ListTile(
                title: Text(
                  'Late Amount',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Center(
                  child: Text(
                    profileData['LATE_AMOUNT'],
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                leading: const Icon(
                  Icons.access_time,
                  size: 48.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: profileData.isNotEmpty
          ? buildInstructorProfile()
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout,
        child: const Icon(Icons.logout),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
