import 'package:flutter/material.dart';

class CyberCScreen extends StatelessWidget {
  const CyberCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: AppBar(title: const Text("C & Cyber Security"), backgroundColor: Colors.blueGrey[900]),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _lessonCard("أساسيات لغة C", "المؤشرات، العناوين، وإدارة الذاكرة."),
          _lessonCard("الأمن السيبراني", "كيف يتم استغلال ثغرات الذاكرة (Buffer Overflow)."),
        ],
      ),
    );
  }

  Widget _lessonCard(String title, String desc) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        title: Text(title, style: const TextStyle(color: Colors.amber)),
        subtitle: Text(desc, style: const TextStyle(color: Colors.white70)),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.amber, size: 15),
        onTap: () {}, // سنبرمج الدروس لاحقاً
      ),
    );
  }
}

