import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CMasterHome(),
));

class CMasterHome extends StatelessWidget {
  const CMasterHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text("C Master Elite V2"),
        backgroundColor: Colors.amber[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.code, size: 80, color: Colors.amber),
            const SizedBox(height: 20),
            const Text(
              "تم التحديث بنجاح! ✅\nأهلاً بك في عالم لغة C",
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "printf('Hello, Tiger!');",
                style: TextStyle(color: Colors.greenAccent, fontFamily: 'monospace', fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
