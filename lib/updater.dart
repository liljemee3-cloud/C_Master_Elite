import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppUpdater {
  final String currentVersion = "1.0.0"; // تأكد أن هذا الرقم هو نفسه في التطبيق

  Future<void> check(BuildContext context) async {
    // 1. إظهار نافذة "جاري الفحص" فوراً ليعرف المستخدم أن النظام يعمل
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.black,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.amber),
            SizedBox(height: 20),
            Text("جاري الاتصال بالسحاب...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );

    final url = 'https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json';
    
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      Navigator.pop(context); // إغلاق نافذة الفحص بمجرد الرد

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String cloudVersion = data['latest_version'];

        if (cloudVersion != currentVersion) {
          _showUpdateDialog(context, cloudVersion, data['url']);
        } else {
          _showSnackBar(context, "تطبيقك محدث (V $currentVersion)");
        }
      }
    } catch (e) {
      Navigator.pop(context); // إغلاق النافذة في حال الخطأ
      _showSnackBar(context, "فشل الاتصال: تأكد من الإنترنت");
    }
  }

  void _showUpdateDialog(BuildContext context, String version, String downloadUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("تحديث متوفر: $version 🚀", style: const TextStyle(color: Colors.amber)),
        content: const Text("تم العثور على دروس وبرمجيات جديدة. هل تبدأ التحميل؟", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("لاحقاً")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              Navigator.pop(context);
              if (await canLaunchUrl(Uri.parse(downloadUrl))) {
                await launchUrl(Uri.parse(downloadUrl), mode: LaunchMode.externalApplication);
              }
            },
            child: const Text("تنزيل الآن"),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
