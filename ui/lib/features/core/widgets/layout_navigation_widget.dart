import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './../constants/navigation_bottom_enum.dart';

import 'package:poc_r/features/dashboard/pages/dashboard_page.dart';
import 'package:poc_r/features/profile/pages/profile_page.dart';

import './../blocs/tab/barrel.dart';
import './tab_selector_widget.dart';

class LayoutNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, NavigationBottomEnum>(
      builder: (context, activeTab) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text(FlutterBlocLocalizations.of(context).appTitle),
          // ),
          body: activeTab == NavigationBottomEnum.dashboard
              ? DashboardPage()
              : ProfilePage(),
          // floatingActionButton: FloatingActionButton(
          //   // key: ArchSampleKeys.addTodoFab,
          //   onPressed: () {
          //     Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
          //   },
          //   child: Icon(Icons.add),
          //   tooltip: ArchSampleLocalizations.of(context).addTodo,
          // ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
