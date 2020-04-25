import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './../constants/core_keys.dart';
import './../constants/navigation_bottom_enum.dart';

class TabSelector extends StatelessWidget {
  final NavigationBottomEnum activeTab;
  final Function(NavigationBottomEnum) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  Icon _getTabIcon(tab) {
    switch (tab) {
      case NavigationBottomEnum.dashboard:
        return Icon(
          Icons.dvr,
          key: CoreKeys.dashboardTab,
        );
      case NavigationBottomEnum.explore:
        return Icon(
          Icons.explore,
          key: CoreKeys.exploreTab,
        );
      case NavigationBottomEnum.stats:
        return Icon(
          Icons.show_chart,
          key: CoreKeys.exploreTab,
        );
      case NavigationBottomEnum.account:
        return Icon(
          Icons.person_outline,
          key: CoreKeys.accountTab,
        );
      default:
        return null;
    }
  }

  Text _getTabTitle(tab) {
    switch (tab) {
      case NavigationBottomEnum.dashboard:
        return Text('tableau de bord');
      case NavigationBottomEnum.explore:
        return Text('découvrir');
      case NavigationBottomEnum.stats:
        return Text('stats');
      case NavigationBottomEnum.account:
        return Text('compte');
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: CoreKeys.tabs,
      currentIndex: NavigationBottomEnum.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(NavigationBottomEnum.values[index]),
      items: NavigationBottomEnum.values.map((tab) {
        return BottomNavigationBarItem(
          icon: _getTabIcon(tab),
          title: _getTabTitle(tab),
        );
      }).toList(),
    );
  }
}
