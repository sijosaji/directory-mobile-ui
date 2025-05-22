import 'package:directory/widgets/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/LoginScreen.dart';
import 'providers/UserMetadataProvider.dart';  

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
    // Call the loadUserMetadata method to load user data when the app starts
    Provider.of<UserMetadataProvider>(context, listen: false).loadUserMetadata();

    return Consumer<UserMetadataProvider>(
      builder: (context, provider, _) {
        // Wait until the metadata is loaded
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: provider.userMetadata.isEmpty
              ? const LoginScreen()  // Show Login if no metadata (logged out)
              : const Homepage(),  // Show Home if metadata exists (logged in)
        );
      },
    );
  }
}
