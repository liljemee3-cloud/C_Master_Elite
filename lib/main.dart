import 'package:flutter/material.dart';
import 'cs50_module.dart';
import 'cyber_security_module.dart';
import 'ai_python_module.dart';
import 'hardware_module.dart';

void main() => runApp(const CMasterApp());

class CMasterApp extends StatelessWidget {
  const CMasterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const AcademyHomeScreen(),
    );
  }
}

class AcademyHomeScreen extends StatelessWidget {
  const AcademyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الموسوعية C Master أكاديمية', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _buildBigButton(context, "منهج CS50 و لغة C", Icons.terminal, Colors.orange, CS50Module()),
            _buildBigButton(context, "الأمن السيبراني", Icons.security, Colors.redAccent, CyberSecurityModule()),
            _buildBigButton(context, "الذكاء الاصطناعي و بايثون", Icons.psychology, Colors.blueAccent, AIModule()),
            _buildBigButton(context, "مكونات الكمبيوتر والهاتف", Icons.settings_input_component, Colors.green, HardwareModule()),
          ],
        ),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, String title, IconData icon, Color color, Widget nextScreen) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => nextScreen)),
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        height: 120,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 40),
            SizedBox(width: 20),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

