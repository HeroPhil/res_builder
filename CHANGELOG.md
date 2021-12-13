## 1.0.0

* `Responsive()`: Define three types of widgets which are automatically chosen based on the screen width.
* `Responsive.builder()`: Define builder methods to build the widgets.
* `Responsive.withShared<T>()`: Define are shared child which can be any type and will be shared between all the layouts.
* `Responsive.value<T>()`: Define a simple value which is responsively chosen.
* To customize the layout behavior, you may override the `upperBound` and/or `lowerBound` static properties as well as the `isMobile`, `isDesktop` and `isTablet` static methods.