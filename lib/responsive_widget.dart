part of res_builder;

class _ResponsiveWidget<T> extends StatelessWidget {
  final BuilderWithChild<T> onMobile;
  final BuilderWithChild<T> onTablet;
  final BuilderWithChild<T> onDesktop;
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
    switch (ResponsiveBuilder.getFormat(context)) {
      case ResponsiveFormat.mobile:
        return onMobile(context, share);
      case ResponsiveFormat.tablet:
        return onTablet(context, share);
      default:
        return onDesktop(context, share);
    }
  }
}
