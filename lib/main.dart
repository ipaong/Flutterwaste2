import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Replace with your actual Supabase URL and Anon Key
  await Supabase.initialize(
    url: 'YOUR_SUPABASE_URL',
    anonKey: 'YOUR_SUPABASE_ANON_KEY',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TUWaste WebApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2E7D32), // Green for waste management theme
          primary: const Color(0xFF2E7D32),
        ),
        useMaterial3: true,
        fontFamily: 'Prompt', // Common Thai font, you can add it to pubspec.yaml later
      ),
      // Use a wrapper to enforce mobile-first layout on Web
      builder: (context, child) {
        return MobileLayoutWrapper(child: child!);
      },
      home: const MyHomePage(),
    );
  }
}

/// A wrapper that centers the content and limits its width on large screens
class MobileLayoutWrapper extends StatelessWidget {
  final Widget child;
  const MobileLayoutWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200], // Background color for the area outside the "phone"
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 500, // Typical max width for mobile apps on web
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TUWaste'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.recycling, size: 80, color: Color(0xFF2E7D32)),
            const SizedBox(height: 20),
            const Text(
              'ยินดีต้อนรับสู่ TUWaste',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Mobile-First WebApp สำหรับการจัดการขยะในมหาวิทยาลัย',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement Login or Navigation
              },
              icon: const Icon(Icons.login),
              label: const Text('เข้าสู่ระบบด้วย Supabase'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
