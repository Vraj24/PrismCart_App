import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:prismcart/constants/error_handling.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/constants/utils.dart';
import 'package:http/http.dart' as http;
import 'package:prismcart/models/user.dart';
import 'package:prismcart/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );
      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              address: jsonDecode(res.body)['address'],
            );

            userProvider.setUserFromModel(user);
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required totalSum}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));
      httpErrorHandle(
        res: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed.');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
        response: res,
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct({
    required BuildContext context,
    required product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httpErrorHandle(
          res: res,
          context: context,
          onSuccess: () {
            onSuccess();
          },
          response: res);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
