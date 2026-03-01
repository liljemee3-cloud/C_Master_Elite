import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const CMasterElite());

class CMasterElite extends StatelessWidget {
  const CMasterElite({super.key});
  final String currentVersion = "1.0.0"; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      ),
      home: HomeScreen(version: currentVersion),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String version;
  const HomeScreen({super.key, required this.version});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    checkUpdates();
  }

  Future<void> checkUpdates() async {
    try {
      // رابط فحص التحديث من مستودعك الجديد
      final response = await http.get(Uri.parse('https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['latest_version'] != widget.version) {
          showUpdateDialog(data['url']);
        }
      }
    } catch (e) {
      print("خطأ في الاتصال بالسحاب: $e");
    }
  }

  void showUpdateDialog(String downloadUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("🚀 تحديث جديد متوفر"),
        content: const Text("يوجد إصدار جديد من الموسوعة، هل تريد التحميل الآن؟"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("لاحقاً"),
          ),
          TextButton(
            onPressed: () async {
              final Uri url = Uri.parse(downloadUrl);
              if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                print("تعذر فتح الرابط");
              }
            },
            child: const Text("تحديث الآن"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C Master Elite"),
        backgroundColor: Colors.amber[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "سوف ترى إذا انجلى الغبارُ\nأفرسٌ تحتك أم حمارُ؟",
              style: TextStyle(fontSize: 22, color: Colors.amber, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            const Text("إصدار التطبيق الحالي: 1.0.0", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
