import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_application_1/page/login.dart';

class MemberProfilePage extends StatefulWidget {
  final Map<String, dynamic> member;

  const MemberProfilePage({Key? key, required this.member}) : super(key: key);

  @override
  _MemberProfilePageState createState() => _MemberProfilePageState();
}

class _MemberProfilePageState extends State<MemberProfilePage> {
  Map<String, dynamic> profileData = {};

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final apiUrl =
        'http://192.168.26.78:8000/api/member/${widget.member['ID_MEMBER']}';
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

  Widget buildMemberProfile() {
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
                    profileData['ID_MEMBER'],
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.attach_money),
                      const SizedBox(width: 8.0),
                      Text(
                        profileData['DEPOSIT_REGULAR_AMOUNT'].toString(),
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        profileData['STATUS_MEMBERSHIP'] == 1
                            ? Icons.check_circle_outline
                            : Icons.cancel_outlined,
                        color: profileData['STATUS_MEMBERSHIP'] == 1
                            ? Colors.green
                            : Colors.red,
                        size: 32.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        profileData['STATUS_MEMBERSHIP'] == 1
                            ? 'Aktif'
                            : 'Tidak Aktif',
                        style: const TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
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
          ? buildMemberProfile()
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _logout,
        child: const Icon(Icons.logout),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
