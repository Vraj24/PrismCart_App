import 'package:flutter/material.dart';
import 'package:prismcart/common/widgets/custom_button.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/features/address/screens/address_screen.dart';
import 'package:prismcart/features/cart/widgets/cart_product.dart';
import 'package:prismcart/features/cart/widgets/cart_subtotal.dart';
import 'package:prismcart/features/home/widgets/address_box.dart';
import 'package:prismcart/features/search/screens/search_screen.dart';
import 'package:prismcart/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(int sum) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: sum.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.grayBackgroundColor),
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Container(
                height: 42,
                margin: const EdgeInsets.only(left: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: TextFormField(
                    onFieldSubmitted: navigateToSearchScreen,
                    decoration: const InputDecoration(
                      prefixIcon: InkWell(
                        // onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 6,
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.black,
                            size: 23,
                          ),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(top: 10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black38,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(7),
                        ),
                      ),
                      hintText: "Search Products",
                      hintStyle: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              height: 42,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: const Icon(
                Icons.mic,
                color: Colors.black,
                size: 25,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.black12,
                height: 5,
              ),
              const AddressBox(),
              const CartSubtotal(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                  text: 'Proceed to Buy (${user.cart.length} items)',
                  onTap: () => navigateToAddress(sum),
                  color: Color.fromRGBO(33, 37, 41, 1),
                ),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Container(
                color: Colors.black12.withOpacity(0.08),
                height: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              ListView.builder(
                itemCount: user.cart.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartProduct(
                    index: index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
