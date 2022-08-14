import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationProvider extends ChangeNotifier {
  static BottomNavigationProvider getProvider(context, [bool listen = false]) =>
      Provider.of<BottomNavigationProvider>(context, listen: listen);

  int currentIndex = 0;
  int currentTab = 0;
  PageController? pageController;
  BottomNavigationProvider([int index = 0]) {
    pageController = PageController(initialPage: index);
    currentIndex = index;
  }

  void changeIndex(int index) {
    if (pageController!.hasClients) {
      this.currentIndex = index;
      pageController!.jumpToPage(index);
      notifyListeners();
    }
  }

  void changeTab(int tab) {
    this.currentIndex = tab;
    notifyListeners();
  }
}
