import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CMasterElite());
}

class CMasterElite extends StatelessWidget {
  const CMasterElite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'C Master Elite',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
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
  // ملاحظة: هذا الرقم في النسخة الجديدة سيكون 2.0.0
  final String currentVersion = "2.0.0";

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
        String latestVersion = data['latest_version'];
        String downloadUrl = data['url'];

        if (latestVersion != "2.0.0") { // التحقق من الإصدار
           // هنا المنطق البرمجي لفحص التحديث
        }
      }
    } catch (e) {
      debugPrint("خطأ: $e");
    }
  }

  void _showUpdateDialog(String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("🚀 تحديث جديد متوفر"),
        content: const Text("تم إضافة بيت شعري جديد ونظام ضخ المعلومات. حدث الآن!"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("لاحقاً")),
          ElevatedButton(onPressed: () => _launchURL(url), child: const Text("تحديث الآن")),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint("خطأ في فتح الرابط");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C Master Elite - V2"),
        backgroundColor: Colors.green[900],
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "العلمُ صيدٌ والكتابةُ قيدُه\nقيّد صيودك بالجبالِ الواثقة",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.greenAccent),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 50),
              Text("الإصدار الحالي: $currentVersion", style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
