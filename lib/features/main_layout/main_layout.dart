import 'dart:developer';

import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/routes_manager.dart';
import 'package:evently_app/features/main_layout/favorite/favorite_tab.dart';
import 'package:evently_app/features/main_layout/home/home_tab.dart';
import 'package:evently_app/features/main_layout/map/map_tab.dart';
import 'package:evently_app/features/main_layout/map/map_tab_provider.dart';
import 'package:evently_app/features/main_layout/profile/profile_tab.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late MapTabProvider provider=context.read<MapTabProvider>();

  int selectedIndexTab = 0;
  List<Widget> tabs = [
    HomeTab(),
    MapTab(),
    FavoriteTab(),
    ProfileTab(),
  ];

  late AppLocalizations? appLocalizations;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appLocalizations = AppLocalizations.of(context);
    bool keyboardIsOpend = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return Scaffold(
      extendBody: true,
      body: tabs[selectedIndexTab],
      bottomNavigationBar: _buildBottomNavBar(context),
      floatingActionButton: keyboardIsOpend ? null : _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomAppBar(
      notchMargin: 6,
      child: BottomNavigationBar(
        onTap: _onTap,
        currentIndex: selectedIndexTab,

        items: [
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndexTab == 0 ? Icons.home : Icons.home_outlined,
            ),
            label: appLocalizations!.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndexTab == 1
                  ? Icons.location_on
                  : Icons.location_on_outlined,
            ),
            label: appLocalizations!.map,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndexTab == 2
                  ? Icons.favorite
                  : Icons.favorite_border_outlined,
            ),
            label: appLocalizations!.favorite,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              selectedIndexTab == 3 ? Icons.person_2 : Icons.person_2_outlined,
            ),
            label: appLocalizations!.profile,
          ),
        ],
      ),
    );
  }

  void _onTap(int newIndex) {

    setState(() {
      selectedIndexTab = newIndex;
    });
  }

  Widget _buildFab() {
    return FloatingActionButton(
      splashColor: Colors.amber,
      onPressed: () async{
        await provider.locationStream?.cancel();
        await Navigator.pushNamed(context, RoutesManager.createEvent);
        if(provider.locationStream!=null){
          provider.getUserLocation();
        }
      },
      child: Icon(Icons.add),
    );
  }
}
