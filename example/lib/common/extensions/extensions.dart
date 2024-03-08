import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../helpers/model.base.dart';

extension GetMediaQuery on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
  ThemeData get theme => Theme.of(this);

  double widthDivideBy(double quotient) => width / quotient;
  double heightDivideBy(double quotient) => height / quotient;
}

extension ShowSnackbar on BuildContext {
  snackbar(
      {required String text,
      Color? backgroundColor,
      Color? textColor,
      Duration? duration,
      SnackBarAction? trailing}) {
    // show snackbar
    // ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      action: trailing,
      content: Text(
        text,
        style: GoogleFonts.raleway(
            fontWeight: FontWeight.w900, color: textColor ?? Colors.blue),
      ),
      backgroundColor: backgroundColor ?? Colors.white,
      duration: duration ?? const Duration(seconds: 2),
    ));
  }
}

extension ReadableDateFormats on BaseModel {
  String get createdReadable => _getReadableCreated();

  String _getReadableCreated() {
    final parsedDateTime = DateTime.parse(created);

    return '${parsedDateTime.year}-${parsedDateTime.month}-${parsedDateTime.day}';
  }
}
