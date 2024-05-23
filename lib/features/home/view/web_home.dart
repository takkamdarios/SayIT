import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:sayit/constants/assets.dart';
import 'package:sayit/features/home/view/home_view.dart';
import 'package:sayit/features/home/widgets/signoutdialog.dart';
import 'package:sayit/features/user_profile/views/web_profile_view.dart';

class WebHomeView extends StatefulWidget {
  const WebHomeView({super.key});

  @override
  State<WebHomeView> createState() => _WebHomeViewState();
}

class _WebHomeViewState extends State<WebHomeView> {
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  bool? isTapped;

  @override
  void initState() {
    isTapped = true;
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: Colors.blueGrey[50],
            body: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  alwaysShowFooter: true,
                  collapseWidth: 1050,
                  controller: sideMenu,
                  style: SideMenuStyle(
                    backgroundColor: Colors.blueGrey[50],
                    openSideMenuWidth: 350,
                    displayMode: SideMenuDisplayMode.auto,
                    hoverColor: Colors.blue[100],
                    selectedColor: Colors.lightBlue,
                    selectedTitleTextStyle:
                        const TextStyle(color: Colors.white),
                    selectedIconColor: Colors.white,
                  ),
                  title: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 150,
                        ),
                        child: Image.asset(LogosAssets.sayitLogo),
                      ),
                      const Divider(
                        indent: 8.0,
                        endIndent: 8.0,
                      ),
                    ],
                  ),
                  items: [
                    SideMenuItem(
                      priority: 0,
                      title: "Home",
                      onTap: (page, _) {
                        sideMenu.changePage(page);
                      },
                      icon: const Icon(FluentSystemIcons.ic_fluent_home_filled),
                    ),
                    SideMenuItem(
                      priority: 1,
                      title: "Profile",
                      onTap: (page, _) {
                        sideMenu.changePage(page);
                      },
                      icon: const Icon(
                          FluentSystemIcons.ic_fluent_person_accounts_filled),
                    ),
                    SideMenuItem(
                      priority: 2,
                      title: 'Sign Out',
                      icon: const Icon(
                          FluentSystemIcons.ic_fluent_sign_out_filled),
                      onTap: (page, _) {
                        HomeDialog.signOutConfirmation(context);
                      },
                    ),
                  ],
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    width: 800,
                    child: PageView(
                      controller: page,
                      children: [
                        const HomeView(),
                        const UserProfileView(),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Only Icon',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
