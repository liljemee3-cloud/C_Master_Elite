import 'package:flutter/material.dart';

class VisualAssets {
  static Widget computerModule() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(Icons.memory, size: 50, color: Colors.orange),
          Text("وحدة المعالجة المركزية (CPU)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          Text("هنا تُنفذ خوارزمياتك بلمح البصر", style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

