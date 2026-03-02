import 'package:flutter/material.dart';

class CyberSecurityModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("الأمن السيبراني"), backgroundColor: Colors.redAccent),
      body: Center(child: Text("هنا سيتم وضع خرائط التشفير وحماية البيانات", style: TextStyle(color: Colors.white))),
    );
  }
}
