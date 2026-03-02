import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppUpdater {
  // تذكر يا نمر: هذا الرقم يجب أن تطابقه يدوياً مع ما تكتبه في version.json
  final String currentVersion = "1.0.0"; 

  Future<void> check(BuildContext context) async {
    // إظهار نافذة الفحص (الدائرة التي تتحرك)
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
            Text("جاري استجواب السحاب...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );

    final url = 'https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json';
    
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      
      // إغلاق نافذة الفحص بمجرد وصول الرد
      if (Navigator.canPop(context)) Navigator.pop(context);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String cloudVersion = data['latest_version'];

        if (cloudVersion != currentVersion) {
          _showUpdateDialog(context, cloudVersion, data['url']);
        } else {
          _showSnackBar(context, "أنت تملك أحدث نسخة حالياً ✅");
        }
      }
    } catch (e) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      _showSnackBar(context, "عذراً، تعذر الوصول للسحاب. تأكد من الإنترنت.");
    }
  }

  void _showUpdateDialog(BuildContext context, String version, String downloadUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("تحديث متوفر: $version 🚀", style: const TextStyle(color: Colors.amber)),
        content: const Text("هناك دروس وبرمجيات جديدة جاهزة للصب في تطبيقك. هل نبدأ؟", 
          style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text("لاحقاً", style: TextStyle(color: Colors.grey))
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              Navigator.pop(context); // إغلاق النافذة
              final Uri _url = Uri.parse(downloadUrl);
              
              // القوة هنا: فتح الرابط خارجياً دون قيود أندرويد (بعد تعديل build.yml)
              if (!await launchUrl(_url, mode: LaunchMode.externalApplication)) {
                _showSnackBar(context, "فشل فتح الرابط، تأكد من وجود متصفح.");
              }
            },
            child: const Text("تنزيل التحديث الآن"),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
