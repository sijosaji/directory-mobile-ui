import 'package:directory/widgets/FamilyProfile.dart';
import 'package:directory/widgets/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';  // Import the provider package

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserMetadataProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class UserMetadataProvider with ChangeNotifier {
  Map<String, dynamic> _userMetadata = {};

  Map<String, dynamic> get userMetadata => _userMetadata;

  void setUserMetadata(Map<String, dynamic> metadata) {
    _userMetadata = metadata;
    notifyListeners(); // Notify listeners when metadata is updated
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    const String apiUrl = "http://192.168.1.36:8080/auth/token";
    const String fetchMetadataUrl = "http://192.168.1.36:8080/api/users/user-metadata";

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'emailId': _usernameController.text,
          'password': _passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String token = data['accessToken'];

        // Fetch metadata
        await _fetchUserMetadata(token, fetchMetadataUrl);

        _showMessage("Login Successful");

        setState(() {
          _isLoading = false;
        });

        // Wait until the metadata is set before navigating
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  FamilyProfile()),
        );
      } else {
        _showMessage("Invalid Login Credentials, please try again.");
      }
    } catch (e) {
      _showMessage("Network error: Unable to connect.");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchUserMetadata(String bearerToken, String url) async {
    try {
      final headers = {
        'Authorization': 'Bearer $bearerToken',
        'Content-Type': 'application/json',
      };

      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final metadata = json.decode(response.body);
        // Store the metadata globally
        Provider.of<UserMetadataProvider>(context, listen: false)
            .setUserMetadata(metadata);
      } else {
        print('Failed to fetch metadata. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching metadata: $error');
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Semi-transparent box
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Please sign in to continue',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 24),
                  // Username TextField
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        backgroundColor: Colors.blue,
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Forgot Password Link
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Forgot Username or Password?',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Contact Administrator Link
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'Not able to sign in? Contact Administrator',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 