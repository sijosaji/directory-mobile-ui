import 'package:flutter/material.dart';

class AdminContactPage extends StatelessWidget {
  const AdminContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Please Contact Administrator for\nusername, password or modification of profile.',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 32),
            const Text(
              'Admin Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.phone, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text('9784538594', style: TextStyle(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.phone, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text('9874657389', style: TextStyle(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.email, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text('stjudeadmin@gmail.com', style: TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 