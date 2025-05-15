import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainTabScaffold extends StatelessWidget {
  final Widget child;

  const MainTabScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateTabIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/search');
              break;
            case 1:
              context.go('/favorites');
              break;
            case 2:
              context.go('/meal-plan');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Meal Plan'),
        ],
      ),
    );
  }

  int _calculateTabIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/favorites')) return 1;
    if (location.startsWith('/meal-plan')) return 2;
    return 0; // default to search
  }
}
