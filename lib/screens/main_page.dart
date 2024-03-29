import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:surdotv_app/widgets/common_widgets.dart';

import '../providers/menu_data.dart';
import '../screens/contact_screen.dart';
import '../screens/search_screen.dart';
import './info_screen.dart';
import './categories_screen.dart';
import './home_screen.dart';

class HomePageScreen extends StatefulWidget {
  static const route_name = '/home-page';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Map<String, Object>> _pages;
  PageController _pageController;

  @override
  void initState() {
    _pages = [
      {
        'title': 'Baş səhifə',
        'page': HomeScreen(),
        'icon': Icon(
          Icons.home,
        ),
      },
      {
        'title': 'Haqqımızda',
        'page': InfoScreen(),
        'icon': Icon(
          Icons.info_outline,
        ),
      },
      {
        'title': 'Bölmələr',
        'page': CategoriesScreen(),
        'icon': Icon(
          Icons.menu,
        ),
      },
      {
        'title': 'Axtarış',
        'page': SearchScreen(),
        'icon': Icon(
          Icons.search,
        ),
      },
      {
        'title': 'Əlaqə',
        'page': ContactScreen(),
        'icon': //SizedBox(height: 30, width: 30, child:svgMail),
            Icon(
          Icons.mail_outline,
        ),
      },
      // ,
      // {
      //   'title': 'Selected Category',
      //   'page': SelectedCategoryScreen(''),
      //   'icon': Icon(Icons.info_outline),
      // }
    ];
    _pageController = PageController();
    super.initState();
  }

  List loadedPages = [
    0,
    2,
  ];
  // List<Widget> _screens = <Widget>[
  //   HomeScreen(),
  //   //  InfoScreen(),
  //   //  CategoriesScreen(),
  //   //  SearchScreen(),
  //   //  ContactScreen()
  // ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuData = Provider.of<MenuData>(context);
    var _screens = [
      HomeScreen(),
      loadedPages.contains(1) ? InfoScreen() : Container(),
      loadedPages.contains(2) ? CategoriesScreen() : Container(),
      loadedPages.contains(3) ? SearchScreen() : Container(),
      loadedPages.contains(4) ? ContactScreen() : Container(),
    ];

    final _ScreenSize = MediaQuery.of(context);

    final _bottomNavBarHeight =
        _ScreenSize.devicePixelRatio * _ScreenSize.size.height * 0.035;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: IndexedStack(
          index: menuData.selectedMenuIndex,
          children: _screens,
        ),
      ),
      // body: SizedBox.expand(
      //   child: PageView(
      //     controller: _pageController,
      //     onPageChanged: (index) {
      //       setState(() => _currentIndex = index);
      //     },
      //     children: [..._pages.map((e) => e['page']).toList()],
      //   ),
      // ), //_pages[menuData.selectedMenuIndex]['page'],

      bottomNavigationBar: Container(
        height: _bottomNavBarHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavyBar(
            selectedIndex: menuData.selectedMenuIndex,
            animationDuration: Duration(milliseconds: 300),
            showElevation: true,
            itemCornerRadius: 20,
            
            onItemSelected: (index) {
              if (!loadedPages.contains(index)) {
                loadedPages.add(index);
              }

              setState(() {
                menuData.setMenuIndex(index);
                menuData.setCategoryId('');
              });

              //Navigator.of(context).pushReplacementNamed(_pages[index]['routeName']);
              // _pageController.jumpToPage(
              //   index,
              // );

              // switch (index) {
              //   case 0:
              //     Navigator.pushReplacementNamed(
              //         context, HomePageScreen.route_name);
              //     break;
              //   case 1:
              //     Navigator.pushReplacementNamed(
              //         context, InfoScreen.route_name);
              //     break;
              //   case 2:
              //     Navigator.pushReplacementNamed(
              //         context, CategoriesScreen.route_name);
              //     break;
              //   case 3:
              //     Navigator.pushReplacementNamed(
              //         context, SearchScreen.route_name);
              //     break;
              //   case 4:
              //     Navigator.pushReplacementNamed(
              //         context, ContactScreen.route_name);
              //     break;
              // }
            },
            items: <BottomNavyBarItem>[
              ..._pages
                  .map((e) => BottomNavyBarItem(
                        activeColor: Theme.of(context).colorScheme.secondary,
                        inactiveColor: Colors.black,
                        title: Text(
                          e['title'],
                          style: Theme.of(context).textTheme.button.copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                        ),
                        icon: e['icon'],
                      ))
                  .toList()
            ],
          ),
          //bottomNavBarNormal(context, widget.selectedBar),
        ),
      ),
    );
  }

  Widget bottomNavBar2(int _selectedPageIndex) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 2),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            unselectedItemColor: Colors.black,
            selectedItemColor: Theme.of(context).colorScheme.secondary,

            currentIndex: _selectedPageIndex, // _selected_index,
            onTap: (index) {
              setState(() {
                //    _selectedPageIndex = index;
                Provider.of<MenuData>(
                  context,
                  listen: false,
                ).setMenuIndex(index);
              });
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                label: 'Info',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu),
                label: 'Sections',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: svgMail, //;Icon(Icons.mail_outline),
                label: 'Message',
              ),
            ],
          ),
        ));
  }
}
