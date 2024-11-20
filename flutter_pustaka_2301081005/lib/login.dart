import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home_page.dart'; // Import halaman MyHome

class Login extends StatefulWidget {
  static const routesName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLogin = true; // Toggle between login and register
  String _apiBaseUrl = 'http://localhost/pustaka_2301081005/users.php'; // Ganti dengan link database Anda

  void _toggleMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      if (_isLogin) {
        await _login(username, password);
      } else {
        await _register(username, password);
      }
    }
  }

  Future<void> _login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiBaseUrl?action=login'),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful! Welcome, $username.')),
          );

          // Navigate to MyHome page
          Navigator.pushReplacementNamed(context, MyHome.routesName);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid username or password.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login. Please try again later.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _register(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_apiBaseUrl?action=register'),
        body: jsonEncode({'username': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration successful! Please login.')),
          );
          _toggleMode(); // Switch to login mode
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: ${data['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register. Please try again later.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Register'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _handleSubmit,
                child: Text(_isLogin ? 'Login' : 'Register'),
              ),
              TextButton(
                onPressed: _toggleMode,
                child: Text(_isLogin
                    ? 'Don’t have an account? Register'
                    : 'Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
