import 'package:flutter/material.dart';
import 'package:template/common_widgets/base_screen.dart';
import 'package:template/common_widgets/buttons.dart';
import 'package:template/router/app_routes.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Page 1',
      children: Center(
        child: AppElevatedButton.primary(
          context: context,
          label: "Go to nested page",
          onPressed: () {
            Page1NestedRoute().go(context);
          },
        ),
      ),
    );
  }
}
