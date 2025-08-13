import 'package:flutter/material.dart';

/// AppTheme provides the consistent blue, black, and white theme
/// for the Hey Coach app as specified in the requirements
class AppTheme {
  // Primary colors
  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  
  // Secondary colors
  static const Color secondaryBlue = Color(0xFF64B5F6);
  static const Color secondaryBlack = Color(0xFF212121);
  static const Color secondaryWhite = Color(0xFFF5F5F5);
  
  // Accent colors
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentRed = Color(0xFFE53935);
  
  // Text colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);
  
  // Background colors
  static const Color backgroundPrimary = Color(0xFFFFFFFF);
  static Color backgroundSecondary =  Colors.blue[50]!;
  static const Color backgroundDark = Color(0xFF212121);
  
  /// Get the light theme data
  static ThemeData getLightTheme() {
    return ThemeData(
      // Primary colors
      primaryColor: primaryBlue,
      primaryColorDark: primaryBlack,
      primaryColorLight: secondaryBlue,
      
      // Color scheme
      colorScheme: const ColorScheme(
        primary: primaryBlue,
        primaryContainer: secondaryBlue,
        secondary: primaryBlack,
        secondaryContainer: secondaryBlack,
        surface: primaryWhite,
        background: backgroundPrimary,
        error: accentRed,
        onPrimary: primaryWhite,
        onSecondary: primaryWhite,
        onSurface: textPrimary,
        onBackground: textPrimary,
        onError: primaryWhite,
        brightness: Brightness.light,
      ),
      
      // Scaffold background color
      scaffoldBackgroundColor: backgroundPrimary,
      
      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlack,
        foregroundColor: primaryWhite,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: primaryWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: primaryWhite,
        ),
      ),
      
      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: primaryWhite,
        selectedItemColor: primaryBlue,
        unselectedItemColor: textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Tab bar theme
      tabBarTheme: const TabBarTheme(
        labelColor: primaryWhite,
        unselectedLabelColor: primaryWhite,
        indicatorColor: primaryBlue,
      ),
      
      // Card theme
      cardTheme: CardTheme(
        color: primaryWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: primaryWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: primaryBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundSecondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(
          color: textLight,
        ),
        labelStyle: const TextStyle(
          color: textSecondary,
        ),
      ),
      
      // Slider theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryBlue,
        inactiveTrackColor: primaryBlue.withOpacity(0.2),
        thumbColor: primaryBlue,
        overlayColor: primaryBlue.withOpacity(0.2),
        valueIndicatorColor: primaryBlue,
        valueIndicatorTextStyle: const TextStyle(
          color: primaryWhite,
        ),
      ),
      
      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryBlue;
          }
          return primaryWhite;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryBlue.withOpacity(0.5);
          }
          return textLight;
        }),
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryBlue;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(primaryWhite),
        side: const BorderSide(color: textSecondary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryBlue;
          }
          return textSecondary;
        }),
      ),
      
      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryBlue,
        circularTrackColor: secondaryBlue,
        linearTrackColor: secondaryBlue,
      ),
      
      // Divider theme
      dividerTheme: const DividerThemeData(
        color: textLight,
        thickness: 1,
        space: 1,
      ),
      
      // Dialog theme
      dialogTheme: DialogTheme(
        backgroundColor: primaryWhite,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: primaryBlack,
        contentTextStyle: const TextStyle(
          color: primaryWhite,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: textPrimary,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryBlue,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: primaryBlue,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: primaryBlue,
        ),
      ),
    );
  }
  
  /// Get the dark theme data
  static ThemeData getDarkTheme() {
    return ThemeData(
      // Primary colors
      primaryColor: primaryBlue,
      primaryColorDark: primaryBlack,
      primaryColorLight: secondaryBlue,
      
      // Color scheme
      colorScheme: const ColorScheme(
        primary: primaryBlue,
        primaryContainer: secondaryBlue,
        secondary: primaryWhite,
        secondaryContainer: secondaryWhite,
        surface: backgroundDark,
        background: primaryBlack,
        error: accentRed,
        onPrimary: primaryWhite,
        onSecondary: primaryBlack,
        onSurface: primaryWhite,
        onBackground: primaryWhite,
        onError: primaryWhite,
        brightness: Brightness.dark,
      ),
      
      // Scaffold background color
      scaffoldBackgroundColor: primaryBlack,
      
      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBlack,
        foregroundColor: primaryWhite,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: primaryWhite,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: primaryWhite,
        ),
      ),
      
      // Bottom navigation bar theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: backgroundDark,
        selectedItemColor: primaryBlue,
        unselectedItemColor: textLight,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Tab bar theme
      tabBarTheme: const TabBarTheme(
        labelColor: primaryWhite,
        unselectedLabelColor: textLight,
        indicatorColor: primaryBlue,
      ),
      
      // Card theme
      cardTheme: CardTheme(
        color: backgroundDark,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      
      // Button themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: primaryWhite,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          side: const BorderSide(color: primaryBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      
      // Input decoration theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: textLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: primaryBlue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: accentRed, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        hintStyle: const TextStyle(
          color: textLight,
        ),
        labelStyle: const TextStyle(
          color: textLight,
        ),
      ),
      
      // Slider theme
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryBlue,
        inactiveTrackColor: primaryBlue.withOpacity(0.2),
        thumbColor: primaryBlue,
        overlayColor: primaryBlue.withOpacity(0.2),
        valueIndicatorColor: primaryBlue,
        valueIndicatorTextStyle: const TextStyle(
          color: primaryWhite,
        ),
      ),
      
      // Switch theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryBlue;
          }
          return primaryWhite;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryBlue.withOpacity(0.5);
          }
          return textLight;
        }),
      ),
      
      // Checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryBlue;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(primaryWhite),
        side: const BorderSide(color: textLight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Radio theme
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryBlue;
          }
          return textLight;
        }),
      ),
      
      // Progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryBlue,
        circularTrackColor: secondaryBlue,
        linearTrackColor: secondaryBlue,
      ),
      
      // Divider theme
      dividerTheme: const DividerThemeData(
        color: textLight,
        thickness: 1,
        space: 1,
      ),
      
      // Dialog theme
      dialogTheme: DialogTheme(
        backgroundColor: backgroundDark,
        elevation: 24,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      
      // Snackbar theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: backgroundDark,
        contentTextStyle: const TextStyle(
          color: primaryWhite,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
      ),
      
      // Text theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: primaryWhite,
        ),
        displayMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: primaryWhite,
        ),
        displaySmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryWhite,
        ),
        headlineLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: primaryWhite,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: primaryWhite,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryWhite,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryWhite,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: primaryWhite,
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: primaryWhite,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: primaryWhite,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: primaryWhite,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: textLight,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: primaryBlue,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: primaryBlue,
        ),
        labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: primaryBlue,
        ),
      ),
    );
  }
  
  /// Common styles for widgets
  
  // Avatar container style
  static BoxDecoration avatarContainerDecoration() {
    return BoxDecoration(
      color: primaryBlue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: primaryBlue.withOpacity(0.3),
        width: 2,
      ),
    );
  }
  
  // Card container style
  static BoxDecoration cardContainerDecoration() {
    return BoxDecoration(
      color: primaryWhite,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: primaryBlack.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
  
  // Feature card style
  static BoxDecoration featureCardDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          primaryBlue,
          secondaryBlue,
        ],
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: primaryBlue.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
  
  // Workout card style
  static BoxDecoration workoutCardDecoration() {
    return BoxDecoration(
      color: primaryWhite,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: primaryBlue.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: primaryBlack.withOpacity(0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
  
  // Streak container style
  static BoxDecoration streakContainerDecoration() {
    return BoxDecoration(
      color: accentOrange.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: accentOrange,
        width: 1,
      ),
    );
  }
  
  // Goal container style
  static BoxDecoration goalContainerDecoration(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: color.withOpacity(0.5),
        width: 1,
      ),
    );
  }
  
  // Notification container style
  static BoxDecoration notificationContainerDecoration() {
    return BoxDecoration(
      color: accentOrange.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: accentOrange,
        width: 1,
      ),
    );
  }
  
  // Progress container style
  static BoxDecoration progressContainerDecoration() {
    return BoxDecoration(
      color: primaryBlue.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
    );
  }
  
  // Common text styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: textPrimary,
  );
  
  static const TextStyle captionStyle = TextStyle(
    fontSize: 14,
    color: textSecondary,
  );
  
  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: primaryWhite,
  );
  
  static const TextStyle linkStyle = TextStyle(
    fontSize: 16,
    color: primaryBlue,
    fontWeight: FontWeight.w500,
  );
}
