import 'package:flutter/material.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/features/account/widgets/below_app_bar.dart';
import 'package:prismcart/features/account/widgets/orders.dart';
import 'package:prismcart/features/account/widgets/top_buttons.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                  color: GlobalVariables.grayBackgroundColor),
            ),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image(
                    image: AssetImage('assets/images/favicon.png'),
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "PrismCart",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 15),
                          child: Icon(
                            Icons.notifications_outlined,
                          ),
                        ),
                        Icon(
                          Icons.search,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
        body: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: GlobalVariables.backgroundGradient,
          ),
          child: Column(
            children: [
              Container(
                color: Colors.black12,
                height: 5,
              ),
              BelowAppBar(),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(padding: EdgeInsets.all(10)),
              TopButtons(),
              Padding(padding: EdgeInsets.all(10)),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(padding: EdgeInsets.all(10)),
              Orders(),
            ],
          ),
        ));
  }
}
