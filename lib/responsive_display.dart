// ignore_for_file: file_names

library responsive_display;

import 'src/responsive_display_api.dart';

export 'src/responsive_display_api.dart';

export 'src/core/breakpoints.dart';
export 'src/core/device_type.dart';
export 'src/core/responsive_config.dart';

export 'src/helpers/responsive_helpers.dart';
export 'src/helpers/responsive_value.dart';

export 'src/widgets/responsive_builder.dart';
export 'src/widgets/responsive_grid.dart';
export 'src/widgets/responsive_layout_builder.dart';
export 'src/widgets/responsive_scaffold.dart';

/// Lowercase alias to satisfy the prompt's `responsiveDisplay.someHelper(...)` request.
/// This allows `responsiveDisplay.deviceType(context)` to work exactly as requested.
// ignore: camel_case_types
typedef responsiveDisplay = ResponsiveDisplay;
