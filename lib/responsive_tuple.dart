part of res_builder;

/// Simple utility class to hold all [ResponsiveFormat] alternatives.
class _ResponsiveTuple<T> {
  late final T _onMobile;
  late final T _onTablet;
  late final T _onDesktop;

  _ResponsiveTuple({
    T? onMobile,
    T? onTablet,
    T? onDesktop,
    ResponsiveFormat? preferredTabletFormat,
  }) {
    assert(
      onMobile != null || onDesktop != null,
      'Neither onMobile nor onDesktop was provided to a Responsive.',
    );

    assert(
      preferredTabletFormat != ResponsiveFormat.tablet,
      "Tablet alternative must not be tablet it self.",
    );
    preferredTabletFormat ??= Responsive.defaultFormat;

    // if tablet is not provided, use desktop or mobile depending on the [preferredTabletFormat].
    _onTablet = onTablet ??
        (preferredTabletFormat == ResponsiveFormat.desktop
            ? onDesktop
            : onMobile)!;

    // ensure that mobile and desktop are not null
    _onMobile = onMobile ?? _onTablet;
    _onDesktop = onDesktop ?? _onTablet;
  }

  T get onMobile => _onMobile;
  T get onTablet => _onTablet;
  T get onDesktop => _onDesktop;
}
