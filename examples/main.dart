import 'package:flutter/material.dart';
import 'package:res_builder/responsive.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  }
}
