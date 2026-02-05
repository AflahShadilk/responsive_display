import 'package:flutter/widgets.dart';
import '../core/device_type.dart';
import '../helpers/responsive_helpers.dart';

/// A simple grid that adjusts its column count based on device type.
class ResponsiveGrid extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  final int? xsmallColumns;
  final int? smallColumns;
  final int? mediumColumns;
  final int? largeColumns;
  final int? xlargeColumns;

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final EdgeInsetsGeometry? padding;
  final double childAspectRatio;

  const ResponsiveGrid({
    super.key,
    required this.children,
    this.gap = 16.0,
    this.xsmallColumns,
    this.smallColumns,
    this.mediumColumns,
    this.largeColumns,
    this.xlargeColumns,
    this.shrinkWrap = false,
    this.physics,
    this.controller,
    this.padding,
    this.childAspectRatio = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    final type = ResponsiveHelpers.deviceType(context);
    int columns = 1;

    switch (type) {
      case DeviceType.xsmall:
        columns = xsmallColumns ?? 1;
        break;
      case DeviceType.small:
        columns = smallColumns ?? 2;
        break;
      case DeviceType.medium:
        columns = mediumColumns ?? 3;
        break;
      case DeviceType.large:
        columns = largeColumns ?? 4;
        break;
      case DeviceType.xlarge:
        columns = xlargeColumns ?? 6;
        break;
    }

    return GridView.count(
      crossAxisCount: columns,
      mainAxisSpacing: gap,
      crossAxisSpacing: gap,
      semanticChildCount: children.length,
      shrinkWrap: shrinkWrap,
      physics: physics,
      controller: controller,
      padding: padding,
      childAspectRatio: childAspectRatio,
      children: children,
    );
  }
}
