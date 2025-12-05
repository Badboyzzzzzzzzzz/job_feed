import 'package:flutter/material.dart';

class JobPostAppTheme {
  static Color backgroundAccent = const Color(0xFFEDEDED);
  static Color red = const Color(0xFFFF0000);

  // Gradient colors for buttons
  static Color gradientStart1 = const Color(0xFFF87D1F);
  static Color gradientEnd1 = const Color(0xFFEC5606);

  // Neutral colors
  static Color white = const Color(0xFFFFFFFF);
  static Color black = const Color(0xFF020202);
  static Color greyDark = const Color(0xFF212121);
  static Color orange = const Color(0xFFF5A522);

  // Background colors
  static Color backgroundLight = const Color(0xFFF5F5F5);
  static Color backgroundWhite = Colors.white;

  // Getters for semantic usage
  static Color get backgroundColor {
    return JobPostAppTheme.backgroundWhite;
  }

  static Color get textSecondary {
    return JobPostAppTheme.greyDark;
  }

  static Color get textLight {
    return JobPostAppTheme.white;
  }

  static Color get divider {
    return JobPostAppTheme.black;
  }

  // Gradient definitions
  static LinearGradient get appHeaderGradient {
    return LinearGradient(
      colors: [gradientStart1, gradientEnd1],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}



