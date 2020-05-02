import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import './../constants/core_keys.dart';
import './../constants/navigation_bottom_enum.dart';

class AnimatedBottomAppBar extends StatefulWidget {
  final NavigationBottomEnum previousTab;
  final NavigationBottomEnum currentTab;
  final Function(NavigationBottomEnum) onTabSelected;

  AnimatedBottomAppBar({
    Key key,
    @required this.previousTab,
    @required this.currentTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  _AnimatedBottomAppBarState createState() => _AnimatedBottomAppBarState(
        previousTab: previousTab,
        currentTab: currentTab,
        onTabSelected: onTabSelected,
      );
}

class _AnimatedBottomAppBarState extends State<AnimatedBottomAppBar>
    with TickerProviderStateMixin {
  final NavigationBottomEnum previousTab;
  final NavigationBottomEnum currentTab;
  final Function(NavigationBottomEnum) onTabSelected;

  int currentIndex;
  int previousIndex;
  List<int> flexValues = [170, 100, 100, 100];
  List<double> opacityValues = [1.0, 0.0, 0.0, 0.0];
  AnimationController _controller;
  Animation animation;

  _AnimatedBottomAppBarState({
    @required this.previousTab,
    @required this.currentTab,
    @required this.onTabSelected,
  }) {
    currentIndex = NavigationBottomEnum.values.indexOf(currentTab);
  }

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
      case NavigationBottomEnum.more:
        return Icon(
          Icons.more_horiz,
          key: CoreKeys.moreTab,
        );
      default:
        return null;
    }
  }

  Widget _getTabTitle(tab) {
    int index = NavigationBottomEnum.values.indexOf(tab);
    String label = '';

    switch (tab) {
      case NavigationBottomEnum.dashboard:
        label = 'acceuil';
        break;
      case NavigationBottomEnum.explore:
        label = 'découvrir';
        break;
      case NavigationBottomEnum.stats:
        label = 'stats';
        break;
      case NavigationBottomEnum.more:
        label = 'plus';
        break;
      default:
        break;
    }

    return index == currentIndex
        ? Opacity(
            opacity: opacityValues[index],
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text(
                label,
              ),
            ))
        : Container();
  }

  _onOptionClicked({@required int pressedIndex}) {
    if (pressedIndex != currentIndex) {
      previousIndex = currentIndex;
      currentIndex = pressedIndex;
      _controller.reset();
      _controller.forward();

      this.onTabSelected(NavigationBottomEnum.values[pressedIndex]);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    animation.addListener(() {
      setState(() {
        flexValues[previousIndex] = 170 - (70 * animation.value).toInt();
        flexValues[currentIndex] = 100 + (70 * animation.value).toInt();
        opacityValues[previousIndex] = 1.0 - animation.value;
        opacityValues[currentIndex] = 0.0 + animation.value;
      });
    });
  }

  Flexible _getTab(index) {
    NavigationBottomEnum tab = NavigationBottomEnum.values[index];

    return Flexible(
      fit: FlexFit.tight,
      flex: flexValues[NavigationBottomEnum.values.indexOf(tab)],
      child: FlatButton(
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: currentIndex == index ? Colors.white : null,
        textColor:
            currentIndex == index ? Theme.of(context).primaryColorDark : null,
        onPressed: () => _onOptionClicked(pressedIndex: index),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _getTabIcon(tab),
            _getTabTitle(tab),
          ],
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return BottomNavigationBar(
  //     key: CoreKeys.tabs,
  //     currentIndex: NavigationBottomEnum.values.indexOf(activeTab),
  //     onTap: (index) => onTabSelected(NavigationBottomEnum.values[index]),
  //     items: NavigationBottomEnum.values.map((tab) {
  //       return BottomNavigationBarItem(
  //         icon: _getTabIcon(tab),
  //         title: _getTabTitle(tab),
  //       );
  //     }).toList(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      key: CoreKeys.tabs,
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        width: double.infinity,
        height: 60.0,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: Row(
                  children: <Widget>[
                    _getTab(0),
                    _getTab(1),
                    _getTab(2),
                    _getTab(3),
                  ],
                ),
              ),
              SizedBox(
                width: 71,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
