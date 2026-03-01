import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MaterialApp(home: CMasterHome()));

class CMasterHome extends StatefulWidget {
  const CMasterHome({super.key});
  @override
  State<CMasterHome> createState() => _CMasterHomeState();
}

class _CMasterHomeState extends State<CMasterHome> {
  final String currentVersion = "1.0.0"; 
  String statusMessage = "جاري الاتصال بالسحاب...";

  @override
  void initState() {
    super.initState();
    checkUpdates();
  }

  Future<void> checkUpdates() async {
    // الرابط المباشر (تأكد من كتابة اسم مستخدم GitHub الخاص بك بدلاً من liljemee3-cloud إذا كان مختلفاً)
    final url = 'https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json';
    
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String cloudVersion = data['latest_version'];
        
        setState(() {
          statusMessage = "نجح الاتصال! نسخة السحاب هي: $cloudVersion";
        });

        if (cloudVersion != currentVersion) {
          _showUpdateDialog(data['url']);
        }
      } else {
        setState(() {
          statusMessage = "فشل الاتصال: كود الخطأ ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        statusMessage = "خطأ تقني: $e";
      });
    }
  }

  void _showUpdateDialog(String downloadUrl) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("🚀 تحديثوا جديد!"),
        content: const Text("هل تريد الانتقال لنسخة لغة C؟"),
        actions: [
          ElevatedButton(
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
      body: Center(
        child: Text(
          statusMessage,
          style: const TextStyle(color: Colors.amber, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
