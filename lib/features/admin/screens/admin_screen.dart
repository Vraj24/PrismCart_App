import 'package:flutter/material.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/features/account/services/account_services.dart';
import 'package:prismcart/features/account/widgets/account_button.dart';
import 'package:prismcart/features/admin/screens/analytics_screen.dart';
import 'package:prismcart/features/admin/screens/orders_screen.dart';
import 'package:prismcart/features/admin/screens/posts_screen.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.grayBackgroundColor),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image(
                image: AssetImage('assets/images/favicon.png'),
                width: 40,
                height: 40,
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 55),
                child: Text(
                  "PrismCart",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // const Text(
              //   'Admin',
              //   style:
              //       TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              // )
              AccountButton(
                text: "Exit",
                onTap: () => AccountServices().logOut(context),
              ),
            ],
          ),
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 0
                          ? (GlobalVariables.selectedNavBarColor ??
                              Colors.black)
                          : (GlobalVariables.backgroundColor),
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: ''),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? (GlobalVariables.selectedNavBarColor ?? Colors.black)
                        : (GlobalVariables.backgroundColor),
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.analytics_outlined),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? (GlobalVariables.selectedNavBarColor ?? Colors.black)
                        : (GlobalVariables.backgroundColor),
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.all_inbox_outlined),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
