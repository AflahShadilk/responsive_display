/// Defines the categorization of devices based on their screen width.
enum DeviceType {
  /// Extra small devices (phones in portrait), width range: 0 - 359px
  xsmall,

  /// Small devices (large phones), width range: 360 - 599px
  small,

  /// Medium devices (tablets), width range: 600 - 899px
  medium,

  /// Large devices (desktop/landscape tablets), width range: 900 - 1279px
  large,

  /// Extra large devices (large desktops), width range: 1280+ px
  xlarge,
}
