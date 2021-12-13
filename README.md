<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A Flutter Widget for building responsive UI.

## Features

* `Responsive()`: Define three types of widgets which are automatically chosen based on the screen width.
* `Responsive.builder()`: Define builder methods to build the widgets.
* `Responsive.withShared<T>()`: Define are shared child which can be any type and will be shared between all the layouts.
* `Responsive.value<T>()`: Define a simple value which is responsively chosen.
* To customize the layout behavior, you may override the `upperBound` and/or `lowerBound` static properties as well as the `isMobile`, `isDesktop` and `isTablet` static methods.
 

## Getting started

* Import the package: `import 'package:res_builder/responsive.dart`;

## Usage

```dart
import 'package:res_builder/responsive.dart';

...

    MaterialApp(
      title: '''
          Responsive Demo on 
          ${Responsive.value<String>(
        context: context,
        onMobile: 'Mobile',
        onTablet: 'Tablet',
        onDesktop: 'Desktop',
      )}
          ''',
      home: Scaffold(
        body: Responsive.withShared<List<Widget>>(
          share: [
            const Text("Responsive Layout"),
            Responsive(
              onMobile: const Text("Im inside of a Column"),
              onDesktop: const Text("Im inside of a Row"),
            ),
          ],
          onMobile: (context, children) => Column(
            children: children,
          ),
          onDesktop: (context, children) => Row(
            children: children,
          ),
        ),
      ),
    );
```

## Additional information

Don't hesitate to contact me if you have questions or ideas.
