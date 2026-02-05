import 'package:flutter/widgets.dart';
import '../core/device_type.dart';
import '../core/breakpoints.dart';
import '../core/responsive_config.dart';

/// Internal helper to determine device type from width and breakpoints.
DeviceType getDeviceTypeRaw(double width, [BuildContext? context]) {
  final breakpoints = context != null
      ? ResponsiveConfig.breakpointsOf(context)
      : Breakpoints.defaults;

  if (width <= breakpoints.xsmall) return DeviceType.xsmall;
  if (width <= breakpoints.small) return DeviceType.small;
  if (width <= breakpoints.medium) return DeviceType.medium;
  if (width <= breakpoints.large) return DeviceType.large;
  return DeviceType.xlarge;
}

/// Helper functions for responsive calculations and device detection.
class ResponsiveHelpers {
  /// Gets the [DeviceType] for the current context.
  static DeviceType deviceType(BuildContext context) {
    final width = screenWidth(context);
    return getDeviceTypeRaw(width, context);
  }

  /// Returns true if the device is considered a phone (xsmall or small).
  static bool isPhone(BuildContext context) {
    final type = deviceType(context);
    return type == DeviceType.xsmall || type == DeviceType.small;
  }

  /// Returns true if the device is considered a tablet (medium).
  static bool isTablet(BuildContext context) {
    return deviceType(context) == DeviceType.medium;
  }

  /// Returns true if the device is considered a desktop (large or xlarge).
  static bool isDesktop(BuildContext context) {
    final type = deviceType(context);
    return type == DeviceType.large || type == DeviceType.xlarge;
  }

  /// Gets the screen width (or more accurately, the view width).
  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  /// Gets the screen height.
  static double screenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
