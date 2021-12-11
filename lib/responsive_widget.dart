part of res_builder;

/// The [Responsive] widgets sister class to choose and render the provided Widget.
///
/// This is universal for all Responsive Builder styles.
class _ResponsiveWidget<T> extends StatelessWidget {
  final BuilderWithShared<T> onMobile;
  final BuilderWithShared<T> onTablet;
  final BuilderWithShared<T> onDesktop;
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
      default:
        return onDesktop(context, share);
    }
  }
}
