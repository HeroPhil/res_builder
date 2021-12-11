library res_builder;

import 'package:flutter/widgets.dart';
import './responsive_format.dart';

part './responsive_widget.dart';

typedef Widget Builder(BuildContext context);
typedef Widget BuilderWithChild<T>(BuildContext context, T child);

class Responsive extends StatelessWidget {
  static double upperBound = 1550;
  static double lowerBound = 850;

  static ResponsiveFormat defaultFormat = ResponsiveFormat.desktop;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < lowerBound;
  static bool isTablet(BuildContext context) =>
      lowerBound <= MediaQuery.of(context).size.width &&
      MediaQuery.of(context).size.width <= upperBound;
  static bool isDesktop(BuildContext context) =>
      upperBound < MediaQuery.of(context).size.width;

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

  late final _ResponsiveWidget _responsiveWidget;

  Responsive({
    Key? key,
    Widget? onMobile,
    Widget? onTablet,
    Widget? onDesktop,
  }) {
    assert(onMobile != null || onDesktop != null);

    // if tablet is not provided, use desktop or mobile
    onTablet ??= onDesktop ?? onMobile;

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

  Responsive.builder({
    Builder? onMobile,
    Builder? onTablet,
    Builder? onDesktop,
  }) {
    assert(onMobile != null || onDesktop != null);

    // if tablet is not provided, use desktop or mobile
    onTablet ??= onDesktop ?? onMobile;

    // ensure that mobile and desktop are not null
    onMobile ??= onTablet;
    onDesktop ??= onTablet;

    // at this stage all three widgets types are not null
    this._responsiveWidget = _ResponsiveWidget<dynamic>(
      onMobile: (BuildContext context, _) => onMobile!(context),
      onTablet: (BuildContext context, _) => onTablet!(context),
      onDesktop: (BuildContext context, _) => onDesktop!(context),
      share: null,
    );
  }

  Responsive._withShared({
    required _ResponsiveWidget responsiveWidget,
  }) {
    _responsiveWidget = responsiveWidget;
  }

  static Responsive withShared<T>({
    BuilderWithChild<T>? onMobile,
    BuilderWithChild<T>? onTablet,
    BuilderWithChild<T>? onDesktop,
    required T share,
  }) {
    assert(share != null);
    assert(onMobile != null || onDesktop != null);

    // if tablet is not provided, use desktop or mobile
    onTablet ??= onDesktop ?? onMobile;

    // ensure that mobile and desktop are not null
    onMobile ??= onTablet;
    onDesktop ??= onTablet;

    // at this stage all three widgets types are not null
    return Responsive._withShared(
      responsiveWidget: _ResponsiveWidget(
        onMobile: (BuildContext context, share) => onMobile!(context, share),
        onTablet: (BuildContext context, share) => onTablet!(context, share),
        onDesktop: (BuildContext context, share) => onDesktop!(context, share),
        share: share,
      ),
    );
  }

  static T value<T>({
    required BuildContext context,
    T? onMobile,
    T? onDesktop,
    T? onTablet,
  }) {
    assert(onMobile != null || onDesktop != null);

    // if tablet is not provided, use desktop or mobile
    onTablet ??= onDesktop ?? onMobile;

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

  @override
  Widget build(BuildContext context) {
    return _responsiveWidget;
  }
}
