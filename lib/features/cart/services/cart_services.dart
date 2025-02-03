import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prismcart/constants/error_handling.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/constants/utils.dart';
import 'package:prismcart/models/product.dart';
import 'package:prismcart/models/user.dart';
import 'package:prismcart/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.delete(
        Uri.parse('$uri/api/remove-from-cart/${product.id}'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user.copyWith(
            cart: jsonDecode(res.body)['cart'],
          );
          userProvider.setUserFromModel(user);
        }, response: res,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
