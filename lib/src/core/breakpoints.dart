import 'package:flutter/foundation.dart';

/// Configuration for breakpoint boundaries for different device types.
@immutable
class Breakpoints {
  /// Max width for xsmall devices. Defaults to 359.
  final double xsmall;

  /// Max width for small devices. Defaults to 599.
  final double small;

  /// Max width for medium devices. Defaults to 899.
  final double medium;

  /// Max width for large devices. Defaults to 1279.
  final double large;

  const Breakpoints({
    this.xsmall = 359,
    this.small = 599,
    this.medium = 899,
    this.large = 1279,
  });

  /// Default configuration for breakpoints code.
  static const Breakpoints defaults = Breakpoints();
}
