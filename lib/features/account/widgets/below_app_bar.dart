import 'package:flutter/material.dart';
import 'package:prismcart/providers/user_provider.dart';
import 'package:provider/provider.dart';

class BelowAppBar extends StatelessWidget {
  const BelowAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      color: Color(0xFFB5FFFC),
      padding: const EdgeInsets.only(top: 10, right: 10, bottom: 10, left: 25),
      child: Row(
        children: [
          RichText(
            text: TextSpan(
              text: "Hello, ",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
              children: [
                TextSpan(
                  text: user.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
