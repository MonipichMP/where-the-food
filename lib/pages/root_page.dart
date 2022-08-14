import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:where_the_food/constant/app_color.dart';
import 'package:where_the_food/provider/bottom_navigation_provider.dart';
import 'package:where_the_food/utils/toast_message_util.dart';

class RootPage extends StatefulWidget {
  final int startPageIndex;

  const RootPage({Key? key, this.startPageIndex = 0}) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  List<Widget> get pages => [
        Container(),
        Container(),
        Container(),
        Container(),
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime? backButtonPressedTime;
    return Consumer<BottomNavigationProvider>(
      builder: (context, state, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: WillPopScope(
          onWillPop: () async {
            if (state.currentIndex != 0) {
              state.changeIndex(0);
              return false;
            } else {
              DateTime currentTime = DateTime.now();
              bool backButton = backButtonPressedTime == null ||
                  currentTime.difference(backButtonPressedTime!) > const Duration(seconds: 3);

              if (backButton) {
                backButtonPressedTime = currentTime;
                toastMessageError("Tap Again to Exit", context);
                return false;
              }
            }
            return true;
          },
          child: Scaffold(
            body: PageView(
              controller: state.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: pages,
            ),
            bottomNavigationBar: RootPageBottomNavigation(state: state),
          ),
        ),
      ),
    );
  }
}

class RootPageBottomNavigation extends StatelessWidget {
  final BottomNavigationProvider state;

  const RootPageBottomNavigation({required this.state});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: state.currentIndex,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: const TextStyle(fontSize: 0),
      unselectedLabelStyle: const TextStyle(fontSize: 0),
      onTap: (index) {
        FocusScope.of(context).unfocus();
        state.changeIndex(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            FlutterIcons.home_fou,
            color: AppColor.bottomNavColor,
            size: 20,
          ),
          activeIcon: Icon(
            FlutterIcons.home_fou,
            color: AppColor.primary,
            size: 20,
          ),
          label: "",
          tooltip: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FlutterIcons.page_search_fou,
            color: AppColor.bottomNavColor,
            size: 20,
          ),
          activeIcon: Icon(
            FlutterIcons.page_search_fou,
            color: AppColor.primary,
            size: 20,
          ),
          label: "",
          tooltip: "Search",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FlutterIcons.bookmark_fou,
            color: AppColor.bottomNavColor,
            size: 20,
          ),
          activeIcon: Icon(
            FlutterIcons.bookmark_fou,
            color: AppColor.primary,
            size: 20,
          ),
          label: "",
          tooltip: "Bookmark",
        ),
        BottomNavigationBarItem(
          icon: Icon(
            FlutterIcons.settings_fea,
            color: AppColor.bottomNavColor,
            size: 20,
          ),
          activeIcon: Icon(
            FlutterIcons.settings_fea,
            color: AppColor.primary,
            size: 20,
          ),
          label: "",
          tooltip: "Setting",
        ),
      ],
    );
  }
}
