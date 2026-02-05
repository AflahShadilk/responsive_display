import 'package:flutter/widgets.dart';
import '../core/device_type.dart';
import '../helpers/responsive_helpers.dart';

typedef ResponsiveLayoutWidgetBuilder = Widget Function(
  BuildContext context,
  BoxConstraints constraints,
  DeviceType deviceType,
);

/// A widget that defers to [LayoutBuilder] but also provides the resolvable [DeviceType]
/// based on the constraints.
class ResponsiveLayoutBuilder extends StatelessWidget {
  final ResponsiveLayoutWidgetBuilder builder;

  const ResponsiveLayoutBuilder({
    super.key,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // We calculate device type based on the BoxConstraints max width here,
        // rather than the global screen width, to support nested responsiveness (e.g. inside a side panel).
        final width = constraints.maxWidth;
        final type = getDeviceTypeRaw(width, context);
        return builder(context, constraints, type);
      },
    );
  }
}
