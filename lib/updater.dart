import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

class AppUpdater {
  // الرابط الخام لملف التحديث في مستودعك
  static const String jsonUrl = "https://github.com/liljemee3-cloud/C_Master_Elite/raw/refs/heads/main/version.json";

  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(jsonUrl));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String latestVersion = data['latest_version'];
        String downloadUrl = data['url'];

        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String currentVersion = packageInfo.version;

        // إذا كان الإصدار السحابي يختلف عن إصدار الهاتف، اظهر نافذة التحديث
        if (latestVersion != currentVersion) {
          _showUpdateDialog(context, latestVersion, downloadUrl);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تطبيقك محدث لآخر إصدار")),
          );
        }
      } else {
        throw "فشل الوصول للسيرفر: ${response.statusCode}";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشل الاتصال: $e")),
      );
    }
  }

  static void _showUpdateDialog(BuildContext context, String version, String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("تحديث جديد متوفر 🚀"),
        content: Text("إصدار جديد ($version) جاهز للتحميل. هل تريد التحديث الآن؟"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("لاحقاً")),
          ElevatedButton(
            onPressed: () => _launchURL(url),
            child: const Text("تحميل التحديث"),
          ),
        ],
      ),
    );
  }

  static Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'تعذر فتح الرابط: $url';
    }
  }
}
