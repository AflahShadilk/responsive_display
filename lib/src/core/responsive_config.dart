import 'package:flutter/widgets.dart';
import 'breakpoints.dart';

/// A widget that injects responsive configuration into the widget tree.
///
/// Use this to override default breakpoints or other global settings.
class ResponsiveConfig extends InheritedWidget {
  /// The breakpoint configuration to be used by descendants.
  final Breakpoints breakpoints;

  /// The base font size for scaling calculations. Default is 16.0.
  final double baseFontSize;

  /// The reference screen width for scaling calculations. Default is 375.0.
  final double scaleBaseWidth;

  /// Damping factor for font scaling on tablet-sized screens (width > 600). Default is 0.85.
  final double tabletScaleFactor;

  /// Damping factor for font scaling on desktop-sized screens (width > 900). Default is 0.65.
  final double desktopScaleFactor;

  /// Minimum allowed scale multiplier for fonts. Default is 0.5.
  final double fontScaleMinFactor;

  /// Maximum allowed scale multiplier for fonts. Default is 2.0.
  final double fontScaleMaxFactor;

  const ResponsiveConfig({
    super.key,
    required super.child,
    this.breakpoints = Breakpoints.defaults,
    this.baseFontSize = 16.0,
    this.scaleBaseWidth = 375.0,
    this.tabletScaleFactor = 0.85,
    this.desktopScaleFactor = 0.65,
    this.fontScaleMinFactor = 0.5,
    this.fontScaleMaxFactor = 2.0,
  });

  static ResponsiveConfig? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ResponsiveConfig>();
  }

  /// Helper to get breakpoints from the nearest [ResponsiveConfig] or use defaults.
  static Breakpoints breakpointsOf(BuildContext context) {
    return ResponsiveConfig.of(context)?.breakpoints ?? Breakpoints.defaults;
  }

  @override
  bool updateShouldNotify(ResponsiveConfig oldWidget) {
    return breakpoints != oldWidget.breakpoints ||
        baseFontSize != oldWidget.baseFontSize ||
        scaleBaseWidth != oldWidget.scaleBaseWidth ||
        tabletScaleFactor != oldWidget.tabletScaleFactor ||
        desktopScaleFactor != oldWidget.desktopScaleFactor ||
        fontScaleMinFactor != oldWidget.fontScaleMinFactor ||
        fontScaleMaxFactor != oldWidget.fontScaleMaxFactor;
  }
}
