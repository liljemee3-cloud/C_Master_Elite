import 'package:flutter/material.dart';

class HardwareModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("مكونات الكمبيوتر من الداخل"), backgroundColor: Colors.green),
      body: ListView(
        children: [
           // هنا سنضع صور عالية الجودة للـ Motherboard والـ CPU
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Text("استكشف كيف تتحرك البيانات داخل الهاتف والكمبيوتر", style: TextStyle(color: Colors.white, fontSize: 18)),
           ),
        ],
      ),
    );
  }
}

