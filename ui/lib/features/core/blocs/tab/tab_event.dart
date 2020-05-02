import 'package:equatable/equatable.dart';

import './../../constants/navigation_bottom_enum.dart';

abstract class TabEvent extends Equatable {
  TabEvent();
}

class TabSelected extends TabEvent {
  final NavigationBottomEnum tab;

  TabSelected({this.tab});

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabSelected { tab: $tab }';
}
