import 'package:flutter/material.dart';

hexStringToColor(String hexColor) {
  hexColor = hexColor.toUpperCase().replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor; // the "FF" sets transparency to opaque
  }
  return Color(int.parse(hexColor, radix: 16));
}
