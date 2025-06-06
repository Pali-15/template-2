import 'package:flutter/material.dart';
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
        return const Icon(Icons.home);
      case BottomNavigationTab.page2:
        return const Icon(Icons.person);
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
      child: Scaffold(
        body: SizedBox.expand(child: navigationShell),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          onTap: (newIndex) {
            if (newIndex != navigationShell.currentIndex) {
              navigationShell.goBranch(
                newIndex,
                initialLocation: newIndex == navigationShell.currentIndex,
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
          selectedLabelStyle: context.textStyles.subtitle.copyWith(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: context.textStyles.subtitle,
        ),
      ),
    );
  }
}
