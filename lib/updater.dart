import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppUpdater {
  // هذا هو الإصدار الذي تضعه في التطبيق يدوياً كل مرة
  final String currentVersion = "1.0.0"; 

  Future<void> check(BuildContext context) async {
    // إظهار رسالة "جاري البحث..."
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("جاري البحث عن تحديثات..."), duration: Duration(seconds: 1)),
    );

    final url = 'https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String cloudVersion = data['latest_version'];

        if (cloudVersion != currentVersion) {
          _showUpdateDialog(context, cloudVersion, data['url']);
        } else {
          _showStatusDialog(context, "لا توجد نسخة جديدة", "تطبيقك محدث بالكامل (V $currentVersion)");
        }
      }
    } catch (e) {
      _showStatusDialog(context, "فشل الاتصال", "تأكد من اتصالك بالإنترنت وحاول مجدداً.");
    }
  }

  void _showUpdateDialog(BuildContext context, String version, String downloadUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("نسخة جديدة متوفرة ($version)", style: const TextStyle(color: Colors.amber)),
        content: const Text("تم رصد معلومات جديدة في السحاب. هل تريد البدء بالتحديث؟", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("ليس الآن")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () {
              Navigator.pop(context);
              _simulateDownload(context, downloadUrl);
            },
            child: const Text("تحديث الآن"),
          ),
        ],
      ),
    );
  }

  void _simulateDownload(BuildContext context, String url) async {
    // إظهار واجهة "جارٍ التحديث" مع خط التقدم
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: const Text("جارٍ التحميل...", style: TextStyle(color: Colors.white)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const LinearProgressIndicator(color: Colors.amber),
                const SizedBox(height: 20),
                const Text("يتم الآن جلب البيانات الجديدة من السحاب", style: TextStyle(color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );

    // الانتظار قليلاً لمحاكاة التحميل ثم فتح الرابط
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pop(context); // إغلاق نافذة التحميل
    
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      _showStatusDialog(context, "تم التحميل", "يرجى تثبيت الملف الذي تم تحميله لتظهر المعلومات الجديدة.");
    }
  }

  void _showStatusDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("حسناً"))],
      ),
    );
  }
}
