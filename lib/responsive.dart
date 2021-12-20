library res_builder;

import 'package:flutter/widgets.dart';
import './responsive_format.dart';

part './responsive_widget.dart';

/// A Builder which receives a [BuildContext] and expects to return a [Widget].
typedef Widget Builder(BuildContext context);

/// A Builder which receives a [BuildContext] and shared [Widget] and expects to return a [Widget].
typedef Widget BuilderWithShared<T>(BuildContext context, T sharedWidget);

/// A function which returns a bool depending on the [BuildContext]. Should evaluate a MediaQuery value.
typedef bool IsResponsiveFormat(BuildContext context);

/// Lets you define alternate widgets for different screen sizes.
///
/// Different constructors are provided for different use cases.
/// Use [Responsive.builder] to create a [Responsive] from a [Builder].
/// Use [Responsive.withShared] to create a [Responsive] from a [BuilderWithShared] to share a Widget between different [ResponsiveFormat]s.
///
/// A Screen is considered to be [ResponsiveFormat.mobile] if the screen width is below the [lowerBound] (default: 850px).
/// A Screen is considered to be [ResponsiveFormat.desktop] if the screen width is equal or above the [upperBound] (default: 1550px).
/// Anything in between is considered a [ResponsiveFormat.tablet] screen.
/// To customize this behavior, you may override the [upperBound] and/or [lowerBound] static properties as well as the [isMobile], [isDesktop] and [isTablet] static methods.
class Responsive extends StatelessWidget {
  /// the upper bound of the screen width. If the screen width is equal or above this value, its considered a [ResponsiveFormat.desktop] screen.
  static double upperBound = 1550;

  /// the lower bound of the screen width. If the screen width is below this value, its considered a [ResponsiveFormat.mobile] screen.
  static double lowerBound = 850;

  /// The default [ResponsiveFormat] for the [Responsive] widget. If for any reason no other [ResponsiveFormat] can be determined, this one is used.
  static ResponsiveFormat defaultFormat = ResponsiveFormat.desktop;

  // ignore: prefer_function_declarations_over_variables
  static IsResponsiveFormat isMobile =
      (BuildContext context) => MediaQuery.of(context).size.width < lowerBound;

  // ignore: prefer_function_declarations_over_variables
  static IsResponsiveFormat isTablet = (BuildContext context) =>
      lowerBound <= MediaQuery.of(context).size.width &&
      MediaQuery.of(context).size.width <= upperBound;

  // ignore: prefer_function_declarations_over_variables
  static IsResponsiveFormat isDesktop =
      (BuildContext context) => upperBound < MediaQuery.of(context).size.width;

  /// Returns the current [ResponsiveFormat] based on the [isMobile], [isDesktop] and [isTablet] methods.
  static ResponsiveFormat getFormat(BuildContext context) {
    if (isMobile(context)) {
      return ResponsiveFormat.mobile;
    }
    if (isTablet(context)) {
      return ResponsiveFormat.tablet;
    }
    if (isDesktop(context)) {
      return ResponsiveFormat.desktop;
    }
    return defaultFormat;
  }

  /// The actual responsive widget.
  late final _ResponsiveWidget _responsiveWidget;

  /// Creates a [Responsive] Widget which returns on of the provided [onMobile], [onTablet] or [onDesktop] Widgets based on the current [ResponsiveFormat].
  ///
  /// At least [onMobile] or [onDesktop] must be provided.
  Responsive({
    Key? key,
    Widget? onMobile,
    Widget? onTablet,
    Widget? onDesktop,
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
    preferredTabletFormat ??= defaultFormat;

    // if tablet is not provided, use desktop or mobile depending on the [preferredTabletFormat].
    onTablet ??= (preferredTabletFormat == ResponsiveFormat.desktop
        ? onDesktop
        : onMobile);

    // ensure that mobile and desktop are not null
    onMobile ??= onTablet;
    onDesktop ??= onTablet;

    // at this stage all three widgets types are not null
    this._responsiveWidget = _ResponsiveWidget(
      onMobile: (_, __) => onMobile!,
      onTablet: (_, __) => onTablet!,
      onDesktop: (_, __) => onDesktop!,
      share: null,
    );
  }

  /// Creates a [Responsive] Widget which returns either of the provided [onMobile], [onTablet] or [onDesktop] Widgets based on the current [ResponsiveFormat].
  ///
  /// This builder constructor allows you to utilize a new builder scope.
  /// At least [onMobile] or [onDesktop] must be provided.
  Responsive.builder({
    Builder? onMobile,
    Builder? onTablet,
    Builder? onDesktop,
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
    preferredTabletFormat ??= defaultFormat;

    // if tablet is not provided, use desktop or mobile depending on the [preferredTabletFormat].
    onTablet ??= (preferredTabletFormat == ResponsiveFormat.desktop
        ? onDesktop
        : onMobile);

    // ensure that mobile and desktop are not null
    onMobile ??= onTablet;
    onDesktop ??= onTablet;

    // at this stage all three widgets types are not null
    _responsiveWidget = _ResponsiveWidget<dynamic>(
      onMobile: (BuildContext context, _) => onMobile!(context),
      onTablet: (BuildContext context, _) => onTablet!(context),
      onDesktop: (BuildContext context, _) => onDesktop!(context),
      share: null,
    );
  }

  /// internal constructor for [Responsive.withShared].
  Responsive._withShared({
    required _ResponsiveWidget responsiveWidget,
  }) {
    _responsiveWidget = responsiveWidget;
  }

  /// Creates a [Responsive] Widget which returns either of the provided [onMobile], [onTablet] or [onDesktop] Widgets based on the current [ResponsiveFormat].
  ///
  /// This static [withShared] method constructs a [Responsive] widget and allows you to share a child Widget between different [ResponsiveFormat]s.
  /// At least [onMobile] or [onDesktop], and a [share] must be provided.
  static Responsive withShared<T>({
    BuilderWithShared<T>? onMobile,
    BuilderWithShared<T>? onTablet,
    BuilderWithShared<T>? onDesktop,
    required T share,
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
    preferredTabletFormat ??= defaultFormat;

    // if tablet is not provided, use desktop or mobile depending on the [preferredTabletFormat].
    onTablet ??= (preferredTabletFormat == ResponsiveFormat.desktop
        ? onDesktop
        : onMobile);

    // ensure that mobile and desktop are not null
    onMobile ??= onTablet;
    onDesktop ??= onTablet;

    // at this stage all three widgets types are not null
    return Responsive._withShared(
      responsiveWidget: _ResponsiveWidget(
        onMobile: (BuildContext context, shared) => onMobile!(context, shared),
        onTablet: (BuildContext context, shared) => onTablet!(context, shared),
        onDesktop: (BuildContext context, shared) =>
            onDesktop!(context, shared),
        share: share,
      ),
    );
  }

  /// Creates a simple Value of one of the provided [onMobile], [onTablet] or [onDesktop] values based on the current [ResponsiveFormat].
  ///
  /// At least [onMobile] or [onDesktop] must be provided.
  static T value<T>({
    required BuildContext context,
    T? onMobile,
    T? onDesktop,
    T? onTablet,
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
    preferredTabletFormat ??= defaultFormat;

    // if tablet is not provided, use desktop or mobile depending on the [preferredTabletFormat].
    onTablet ??= (preferredTabletFormat == ResponsiveFormat.desktop
        ? onDesktop
        : onMobile);

    // ensure that mobile and desktop are not null
    onMobile ??= onTablet;
    onDesktop ??= onTablet;

    switch (getFormat(context)) {
      case ResponsiveFormat.mobile:
        return onMobile!;
      case ResponsiveFormat.tablet:
        return onTablet!;
      default:
        return onDesktop!;
    }
  }

  /// the widget build method which returns the chosen Widget.
  @override
  Widget build(BuildContext context) {
    return _responsiveWidget;
  }
}
