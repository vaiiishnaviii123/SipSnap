import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sipsnap/view/common_widgets/custom_drawer.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ScaffoldWithNavigationBar(
        body: navigationShell,
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _goBranch,
      );
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({super.key, 
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(253, 220, 198, 1),
        title: const Text('Sip Snap', style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(size: 20, color: Colors.black),
      ),
      drawer: const CustomDrawer(),
      body: body,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Color.fromRGBO(253, 220, 198, 1),
        indicatorColor: Colors.orangeAccent,
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
              label: 'Community',
              icon: Icon(Icons.people, color: Colors.black,),
          ),
          NavigationDestination(
              label: 'Create',
              icon: Icon(Icons.add,color: Colors.black,),
      ),
          NavigationDestination(
              label: 'Recipe',
              icon: Icon(Icons.restaurant,color: Colors.black,),
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}