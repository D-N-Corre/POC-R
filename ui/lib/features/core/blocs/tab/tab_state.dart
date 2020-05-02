import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poc_r/features/core/constants/navigation_bottom_enum.dart';

abstract class TabState extends Equatable {
  final NavigationBottomEnum previousTab = null;
  final NavigationBottomEnum currentTab = NavigationBottomEnum.dashboard;

  @override
  List<Object> get props => [currentTab];
}

class TabInitial extends TabState {
  @override
  String toString() => 'TabInitial { currentTab: $currentTab }';
}

class TabUpdated extends TabState {
  final NavigationBottomEnum currentTab;
  final NavigationBottomEnum previousTab;

  TabUpdated({
    @required this.currentTab,
    @required this.previousTab,
  });

  @override
  List<Object> get props => [currentTab, previousTab];

  @override
  String toString() =>
      'TabUpdated { currentTab: $currentTab, previousTab: $previousTab }';
}
