import 'package:flutter/material.dart';

import 'package:wysowl/src/constants/colors/main_colors.dart';

ButtonStyle elevatedButtonStyle({required double padding,Color bgColor = primaryColor}) {


  return ElevatedButton.styleFrom(
    elevation: 0.8,
    backgroundColor: bgColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    padding: EdgeInsets.symmetric(vertical: padding)
  );
}

