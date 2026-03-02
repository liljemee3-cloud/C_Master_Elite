import 'package:flutter/material.dart';
import 'updater.dart'; // تأكد أن ملف updater.dart موجود في نفس المجلد

void main() {
  runApp(const CMasterApp());
}

class CMasterApp extends StatelessWidget {
  const CMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C Master Elite',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // فحص التحديث تلقائياً عند فتح التطبيق (اختياري)
    // AppUpdater.checkForUpdate(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('C Master Elite'),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.black, // الخلفية السوداء التي تفضلها
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.code, size: 100, color: Colors.orange),
              const SizedBox(height: 20),
              const Text(
                'مرحباً بك فــــي عالم البرمجة بلغة C',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 40),
              // زر التحديث الأساسي
              ElevatedButton.icon(
                onPressed: () {
                  AppUpdater.checkForUpdate(context);
                },
                icon: const Icon(Icons.system_update),
                label: const Text('فحص وجود تحديثات'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
