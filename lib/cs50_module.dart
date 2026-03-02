import 'package:flutter/material.dart';

class CS50Module extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("منهج CS50 و لغة C"), backgroundColor: Colors.orange),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _buildLessonCard("المعالج والذاكرة", "يقول دنيس ريتشي: C لغة قوية لأنها تمنحك مفاتيح الآلة.", "https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/C_Programming_Language.svg/1200px-C_Programming_Language.svg.png"),
          _buildLessonCard("خوارزميات البحث", "الخوارزمية هي وصفة الحل. البحث الثنائي أسرع بآلاف المرات من البحث الخطي.", "https://miro.medium.com/max/1400/1*1S6ZpA-E7R6-P3F6-P3F6-Q.png"),
        ],
      ),
    );
  }

  Widget _buildLessonCard(String title, String info, String imageUrl) {
    return Card(
      color: Colors.grey[900],
      child: Column(
        children: [
          Image.network(imageUrl, height: 200, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(info, style: TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

