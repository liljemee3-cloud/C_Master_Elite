import 'package:flutter/material.dart';
import 'cs50_content.dart'; // هذا هو الملف الذي يحتوي على الأجزاء الخمسة

class CS50Module extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("موسوعة CS50 و لغة C العملاقة"),
        backgroundColor: Colors.orange,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        // هنا المحرك يقرأ عدد الدروس تلقائياً من الملف الضخم
        itemCount: CS50Content.lessons.length, 
        itemBuilder: (context, index) {
          final lesson = CS50Content.lessons[index];
          return Card(
            color: Colors.grey[900],
            margin: EdgeInsets.only(bottom: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                if (lesson['image'] != null)
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(lesson['image']!, fit: BoxFit.cover),
                  ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(lesson['title']!, style: TextStyle(color: Colors.orange, fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text(lesson['scientist']!, style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic)),
                      Divider(color: Colors.orange),
                      Text(lesson['details']!, style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
