import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const CMasterElite());

class CMasterElite extends StatelessWidget {
  const CMasterElite({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
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
  final String currentVersion = "1.0.0"; // إصدارك الحالي

  @override
  void initState() {
    super.initState();
    checkUpdates();
  }

  Future<void> checkUpdates() async {
    try {
      final response = await http.get(Uri.parse('https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['latest_version'] != currentVersion) {
          _showUpdateDialog(data['url']);
        }
      }
    } catch (e) {
      debugPrint("خطأ اتصال: $e");
    }
  }

  void _showUpdateDialog(String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("🚀 تحديث جديد!"),
        content: const Text("هل تريد تجربة نظام التحديث التلقائي؟"),
        actions: [
          ElevatedButton(onPressed: () async {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          }, child: const Text("تحديث الآن")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("النسخة الحالية: $currentVersion\nانتظر التحديث...", textAlign: TextAlign.center)),
    );
  }
}
