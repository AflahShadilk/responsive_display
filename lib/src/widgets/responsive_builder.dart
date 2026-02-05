import 'package:flutter/widgets.dart';
import '../core/device_type.dart';
import '../helpers/responsive_helpers.dart';

/// A widget that builds different child widgets based on the current [DeviceType].
///
/// If a specific device type widget is not provided, it falls back to the nearest
/// smaller device type, or [fallback] if provided.
class ResponsiveBuilder extends StatelessWidget {
  final Widget? xsmall;
  final Widget? small;
  final Widget? medium;
  final Widget? large;
  final Widget? xlarge;
  final Widget Function(DeviceType)? fallback;

  const ResponsiveBuilder({
    super.key,
    this.xsmall,
    this.small,
    this.medium,
    this.large,
    this.xlarge,
    this.fallback,
  });

  @override
  Widget build(BuildContext context) {
    final type = ResponsiveHelpers.deviceType(context);

    if (type == DeviceType.xsmall) {
      if (xsmall != null) return xsmall!;
    }

    if (type == DeviceType.small) {
      if (small != null) return small!;
      if (xsmall != null) return xsmall!;
    }

    if (type == DeviceType.medium) {
      if (medium != null) return medium!;
      if (small != null) return small!;
      if (xsmall != null) return xsmall!;
    }

    if (type == DeviceType.large) {
      if (large != null) return large!;
      if (medium != null) return medium!;
      if (small != null) return small!;
      if (xsmall != null) return xsmall!;
    }

    if (type == DeviceType.xlarge) {
      if (xlarge != null) return xlarge!;
      if (large != null) return large!;
      if (medium != null) return medium!;
      if (small != null) return small!;
      if (xsmall != null) return xsmall!;
    }

    if (fallback != null) {
      return fallback!(type);
    }

    return const SizedBox.shrink();
  }
}
