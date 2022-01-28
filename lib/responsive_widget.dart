part of res_builder;

/// The [Responsive] widgets sister class to choose and render the provided Widget.
///
/// This is universal for all Responsive Builder styles.
class _ResponsiveWidget<T> extends StatelessWidget {
  final ResponsiveBuilderWithShared<T> onMobile;
  final ResponsiveBuilderWithShared<T> onTablet;
  final ResponsiveBuilderWithShared<T> onDesktop;
  final T share;

  const _ResponsiveWidget({
    Key? key,
    required this.onMobile,
    required this.onTablet,
    required this.onDesktop,
    required this.share,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (Responsive.getFormat(context)) {
      case ResponsiveFormat.mobile:
        return onMobile(context, share);
      case ResponsiveFormat.tablet:
        return onTablet(context, share);
      case ResponsiveFormat.desktop:
        return onDesktop(context, share);
    }
  }
}
