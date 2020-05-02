import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_r/features/core/blocs/tab/tab_state.dart';
import 'package:poc_r/features/core/widgets/animated_bottom_app_bar_widget.dart';

import './../constants/navigation_bottom_enum.dart';

import 'package:poc_r/features/dashboard/pages/dashboard_page.dart';
import 'package:poc_r/features/more/pages/more_page.dart';

import './../blocs/tab/barrel.dart';
// import './tab_selector_widget.dart';

class LayoutNavigation extends StatelessWidget {
  Widget _getActivePage(NavigationBottomEnum activeTab) {
    switch (activeTab) {
      case NavigationBottomEnum.dashboard:
        return DashboardPage();
      case NavigationBottomEnum.explore:
        return Container();
      case NavigationBottomEnum.stats:
        return Container();
      case NavigationBottomEnum.more:
        return MorePage();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, TabState>(
      builder: (context, tabState) {
        return SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   title: Text(FlutterBlocLocalizations.of(context).appTitle),
            // ),
            body: _getActivePage(tabState.currentTab),
            floatingActionButton: FloatingActionButton(
              // key: ArchSampleKeys.addTodoFab,
              onPressed: () {
                // Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
              },
              child: Icon(Icons.add),
              // tooltip: ArchSampleLocalizations.of(context).addTodo,
            ),
            // bottomNavigationBar: TabSelector(
            //   activeTab: activeTab,
            //   onTabSelected: (tab) =>
            //       BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
            // ),
            bottomNavigationBar: AnimatedBottomAppBar(
              previousTab: tabState.previousTab,
              currentTab: tabState.currentTab,
              onTabSelected: (tab) =>
                  BlocProvider.of<TabBloc>(context).add(TabSelected(tab: tab)),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
          ),
        );
      },
    );
  }
}
