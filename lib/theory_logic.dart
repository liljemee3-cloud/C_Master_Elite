class TheoryLogic {
  // شرح فيزيائي لكيفية عمل الترانزستور كبوابة منطقية
  static String getTransistorPhysics() {
    return "الترانزستور يعمل كمفتاح (Switch)؛ عندما يمر تيار في 'القاعدة' يسمح بمرور التيار بين 'المجمع' و'المشع' (حالة 1)، وبدونه ينقطع التيار (حالة 0).";
  }

  // خوارزمية تحويل الرقم العشري إلى ثنائي (التي سأختبرك بها)
  static List<int> decimalToBinary(int number) {
    List<int> binary = [];
    // هنا نطبق خوارزمية القسمة المتكررة على 2
    while (number > 0) {
      binary.add(number % 2);
      number = number ~/ 2;
    }
    return binary.reversed.toList();
  }
}

