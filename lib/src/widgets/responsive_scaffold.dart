import 'package:flutter/material.dart';
import '../core/device_type.dart';
import '../helpers/responsive_helpers.dart';

/// A wrapper around [Scaffold] that provides adaptive navigation patterns.
///
/// - Phones (xsmall, small): BottomNavigationBar
/// - Tablets (medium): NavigationRail
/// - Desktop (large, xlarge): NavigationRail or Persistent Drawer (Side Menu)
class ResponsiveScaffold extends StatelessWidget {
  final Widget? title;
  final Widget body;
  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final ValueChanged<int> onNavigationIndexChange;
  final Widget? floatingActionButton;

  const ResponsiveScaffold({
    super.key,
    this.title,
    required this.body,
    required this.items,
    required this.currentIndex,
    required this.onNavigationIndexChange,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final type = ResponsiveHelpers.deviceType(context);

    // Mobile: Bottom Nav
    if (type == DeviceType.xsmall || type == DeviceType.small) {
      return Scaffold(
        appBar: title != null ? AppBar(title: title) : null,
        body: body,
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          currentIndex: currentIndex,
          onTap: onNavigationIndexChange,
        ),
        floatingActionButton: floatingActionButton,
      );
    }

    // Tablet/Desktop: Navigation Rail
    return Scaffold(
      appBar: title != null ? AppBar(title: title) : null,
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: currentIndex,
            onDestinationSelected: onNavigationIndexChange,
            labelType: NavigationRailLabelType.all,
            destinations: items.map((item) {
              return NavigationRailDestination(
                icon: item.icon,
                selectedIcon: item.activeIcon,
                label: Text(item.label ?? ''),
              );
            }).toList(),
            trailing: floatingActionButton != null
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: floatingActionButton,
                  )
                : null,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: body),
        ],
      ),
    );
  }
}
