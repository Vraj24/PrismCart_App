import 'package:flutter/material.dart';
import 'package:prismcart/features/account/services/account_services.dart';
import 'package:prismcart/features/account/widgets/account_button.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              AccountButton(text: "Your Orders", onTap: () {}),
              AccountButton(text: "Turn Seller", onTap: () {}),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AccountButton(
                text: "Log Out",
                onTap: () => AccountServices().logOut(context),
              ),
              AccountButton(text: "Your Wishlist", onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
