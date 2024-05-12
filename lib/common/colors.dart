import 'dart:math';

import 'package:flutter/material.dart';

Color primaryGreenColor = const Color.fromARGB(255, 79, 111, 82);
Color secondaryGreenColor = const Color.fromARGB(255, 26, 77, 46);
Color lightYellowColor = const Color.fromARGB(255, 246, 233, 178);
Color darkYellowColor = const Color.fromARGB(255, 243, 202, 82);

Color generateRandomDarkColor() {
  Random random = Random();
  int red = random.nextInt(128); // Random value between 0 and 127
  int green = random.nextInt(128); // Random value between 0 and 127
  int blue = random.nextInt(128); // Random value between 0 and 127
  return Color.fromARGB(
      255, red, green, blue); // Create color with alpha 255 (opaque)
}

Color generateRandomLightColor() {
  Random random = Random();
  int red = 138 + random.nextInt(90); // Random value between 0 and 127
  int green = 138 + random.nextInt(90); // Random value between 0 and 127
  int blue = 138 + random.nextInt(90); // Random value between 0 and 127
  return Color.fromARGB(
      255, red, green, blue); // Create color with alpha 255 (opaque)
}
