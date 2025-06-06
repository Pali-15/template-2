import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:template/core/extensions/context_extensions/context_design_extension.dart';

enum BottomNavigationTab {
  page1,
  page2;

  // Eligible for localization
  String get label {
    switch (this) {
      case BottomNavigationTab.page1:
        return 'Page 1';
      case BottomNavigationTab.page2:
        return 'Page 2';
    }
  }

  Icon get icon {
    switch (this) {
      case BottomNavigationTab.page1:
        return Icon(Icons.home, size: 20.h);
      case BottomNavigationTab.page2:
        return Icon(Icons.person, size: 20.h);
    }
  }
}

class BottomNavbar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BottomNavbar({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final num scaledWidth = 600;
          final double width =
              scaledWidth.clamp(0.0, constraints.maxWidth).toDouble();
          return Container(
            color:
                context.colors.background, // optional: full-screen background
            child: Center(
              child: SizedBox(
                width: width, // Match your design width
                child: Scaffold(
                  body: SizedBox.expand(child: navigationShell),
                  bottomNavigationBar: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: BottomNavigationBar(
                      backgroundColor: context.colors.background,
                      elevation: 0,
                      currentIndex: navigationShell.currentIndex,
                      onTap: (newIndex) {
                        if (newIndex != navigationShell.currentIndex) {
                          navigationShell.goBranch(
                            newIndex,
                            initialLocation:
                                newIndex == navigationShell.currentIndex,
                          );
                        }
                      },
                      items:
                          BottomNavigationTab.values.map((tab) {
                            return BottomNavigationBarItem(
                              icon: tab.icon,
                              label: tab.label,
                            );
                          }).toList(),
                      type: BottomNavigationBarType.fixed,
                      selectedLabelStyle: context.textStyles.body.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      unselectedLabelStyle: context.textStyles.body,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
