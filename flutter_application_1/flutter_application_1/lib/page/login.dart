import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/member/member_home.dart';
import 'package:flutter_application_1/page/instructor/instructor_home.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _usernameController.text;
      String password = _passwordController.text;

      const String baseurl = 'http://192.168.26.78:8000/api/login';

      Uri url = Uri.parse(baseurl);
      final response = await http.post(url, body: {
        "EMAIL": email,
        "PASSWORD": password,
      });

      final responseData = json.decode(response.body);
      final role = responseData['role'].toString();

      print(role);
      print(responseData['role']);

      if (response.statusCode == 200) {
        if (role == 'Member') {
          final currentMember = responseData['data'] as Map<String, dynamic>;
          _navigateToMemberHomePage(currentMember);
        } else if (role == 'Instructor') {
          final currentInstructor =
              responseData['data'] as Map<String, dynamic>;
          _navigateToInstructorHomePage(currentInstructor);
        }
      } else {
        print("Login failed");
      }
    }
  }

  void _navigateToMemberHomePage(Map<String, dynamic> currentMember) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MemberHomePage(currentMember: currentMember),
        ),
      );
    });
  }

  void _navigateToInstructorHomePage(Map<String, dynamic> currentInstructor) {
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
              InstructorHomePage(currentInstructor: currentInstructor),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: false,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _login,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}
