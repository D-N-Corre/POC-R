import 'dart:async';
import 'package:bloc/bloc.dart';

import './tab_state.dart';
import './tab_event.dart';

class TabBloc extends Bloc<TabEvent, TabState> {
  @override
  TabState get initialState => TabInitial();

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event is TabSelected) {
      yield TabUpdated(currentTab: event.tab, previousTab: state.currentTab);
    }
  }
}
