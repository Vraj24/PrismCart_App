import 'package:flutter/material.dart';
import 'package:prismcart/common/widgets/loader.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/features/home/widgets/address_box.dart';
import 'package:prismcart/features/product_details/screens/product_details_screen.dart';
import 'package:prismcart/features/search/services/search_services.dart';
import 'package:prismcart/features/search/widget/searched_product.dart';
import 'package:prismcart/models/product.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  fetchSearchedProduct() async {
    products = await searchServices.fetchSearchedProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
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
              child: SizedBox(
                height: 42,
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
      body: products == null
          ? const Loader()
          : Container(
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
                  const AddressBox(),
                  Container(
                    color: Colors.black12,
                    height: 5,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetailsScreen.routeName,
                                arguments: products![index],
                              );
                            },
                            child: SearchedProduct(product: products![index]));
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
