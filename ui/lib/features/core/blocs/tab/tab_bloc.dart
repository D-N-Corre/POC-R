import 'dart:async';
import 'package:bloc/bloc.dart';

import './tab_event.dart';
import './../../constants/navigation_bottom_enum.dart';

class TabBloc extends Bloc<TabEvent, NavigationBottomEnum> {
  @override
  NavigationBottomEnum get initialState => NavigationBottomEnum.dashboard;

  @override
  Stream<NavigationBottomEnum> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
