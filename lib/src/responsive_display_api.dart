import 'package:flutter/widgets.dart';

import 'core/device_type.dart';
import 'core/responsive_config.dart';
import 'helpers/responsive_helpers.dart';

/// The unified namespace for accessing responsive capabilities.
///
/// Follows the naming requested in the prompt: `responsiveDisplay`.
/// In Dart, standard class names are UpperCamelCase. We provide `ResponsiveDisplay`
/// which contains all the static logical helpers.
class ResponsiveDisplay {
  /// Private constructor to prevent instantiation.
  ResponsiveDisplay._();

  // -- Device Type Helpers --

  /// Gets the current [DeviceType] from the context.
  static DeviceType deviceType(BuildContext context) =>
      ResponsiveHelpers.deviceType(context);

  /// Returns true if the device is a phone (xsmall or small).
  static bool isPhone(BuildContext context) => ResponsiveHelpers.isPhone(context);

  /// Returns true if the device is a tablet (medium).
  static bool isTablet(BuildContext context) =>
      ResponsiveHelpers.isTablet(context);

  /// Returns true if the device is a desktop (large or xlarge).
  static bool isDesktop(BuildContext context) =>
      ResponsiveHelpers.isDesktop(context);

  /// Gets the screen width.
  static double screenWidth(BuildContext context) =>
      ResponsiveHelpers.screenWidth(context);

  /// Gets the screen height.
  static double screenHeight(BuildContext context) =>
      ResponsiveHelpers.screenHeight(context);

  // -- Proportional Scaling Helpers --
  // Scales based on width, but with safe clamps and checks.

  /// Scales a font size based on the screen width relative to a "standard" mobile width (e.g. 375).
  ///
  /// [base] is the design font size (e.g. 16).
  /// [min] is the minimum allowed font size (optional).
  /// [max] is the maximum allowed font size (optional).
  static double scaleFont(BuildContext context, double base,
      {double? min, double? max}) {
    final width = screenWidth(context);
    final config = ResponsiveConfig.of(context);
    
    // Get values from config or defaults
    final double baseWidth = config?.scaleBaseWidth ?? 375.0;
    final double tabletFactor = config?.tabletScaleFactor ?? 0.85;
    final double desktopFactor = config?.desktopScaleFactor ?? 0.65;
    
    // Calculate scale factor
    double scale = width / baseWidth;

    // Limit extreme scaling on large screens for text
    if (width > 600) {
      scale = scale * tabletFactor; // Dampen scaling on tablets
    }
    if (width > 900) {
      scale = scale * desktopFactor; // Dampen more on desktop
    }

    double scaledValue = base * scale;

    // Respect system text scale factor
    scaledValue = MediaQuery.textScalerOf(context).scale(scaledValue);

    // Apply strict clamping
    // Use config limits if provided and no specific overrides
    final double configMin = config?.fontScaleMinFactor ?? 0.5;
    final double configMax = config?.fontScaleMaxFactor ?? 2.0;

    final double hardMax = max ?? (base * configMax);
    final double hardMin = min ?? (base * configMin);

    return scaledValue.clamp(hardMin, hardMax).toDouble();
  }

  /// Scales spacing (padding/margins) based on screen width.
  static double scaleSpacing(BuildContext context, double base) {
    final width = screenWidth(context);
    const double baseWidth = 375.0;
    
    // Spacing can scale more linearly than text.
    double scale = width / baseWidth;
    
    // Clamp excessive scaling
    if (scale > 2.0) scale = 2.0; 

    return base * scale;
  }

  /// Scales a radius value.
  static double scaleRadius(BuildContext context, double base) {
    // Radius usage is similar to spacing.
    return scaleSpacing(context, base);
  }

  /// Scales an icon size.
  static double scaleIcon(BuildContext context, double base) {
    // Icons should scale similar to text to stay relative.
    return scaleFont(context, base);
  }
  
  /// Helper to access grid columns count based on standard breakpoints.
  static int gridColumns(BuildContext context) {
      // Re-using the logic from ResponsiveGrid's default behavior, expose it as a raw value.
      final type = deviceType(context);
      switch (type) {
      case DeviceType.xsmall: return 1;
      case DeviceType.small: return 2;
      case DeviceType.medium: return 3;
      case DeviceType.large: return 5;
      case DeviceType.xlarge: return 6;
    }
  }
}
