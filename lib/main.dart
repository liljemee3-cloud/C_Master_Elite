import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: CMasterHome(),
));

class CMasterHome extends StatefulWidget {
  const CMasterHome({super.key});
  @override
  State<CMasterHome> createState() => _CMasterHomeState();
}

class _CMasterHomeState extends State<CMasterHome> {
  // الإصدار الحالي في هاتفك (سنعتبره 1.0.0 لنختبر التحديث)
  final String currentVersion = "1.0.0";

  @override
  void initState() {
    super.initState();
    // استدعاء فحص التحديث فور التشغيل
    checkUpdates();
  }

  Future<void> checkUpdates() async {
    // رابط ملف version.json الخاص بك (تأكد من صحة اسم المستخدم والمستودع)
    final url = 'https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String latestVersion = data['latest_version'];
        String downloadUrl = data['url'];

        // إذا وجد رقم إصدار أكبر من الحالي (مثلا 2.0.0)
        if (latestVersion != currentVersion) {
          _showUpdateDialog(downloadUrl);
        }
      }
    } catch (e) {
      print("خطأ في جلب التحديث: $e");
    }
  }

  void _showUpdateDialog(String downloadUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("🚀 تحديث متوفر", style: TextStyle(color: Colors.amber)),
        content: const Text("هناك نسخة جديدة تحتوي على دروس C. هل تريد التحميل؟", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("لاحقاً")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[900]),
            onPressed: () => launchUrl(Uri.parse(downloadUrl), mode: LaunchMode.externalApplication),
            child: const Text("تحديث الآن"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("C Master Elite V1"), backgroundColor: Colors.amber[900]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_sync, size: 100, color: Colors.amber),
            const SizedBox(height: 20),
            Text("الإصدار الحالي: $currentVersion", style: const TextStyle(color: Colors.white)),
            const Text("\nجاري مراقبة السحاب للتحديثات...", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
