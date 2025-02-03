import 'package:flutter/material.dart';
import 'package:prismcart/common/widgets/loader.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/features/home/services/home_services.dart';
import 'package:prismcart/features/home/widgets/address_box.dart';
// ignore: unused_import
import 'package:prismcart/features/home/widgets/carousel_image.dart';
// ignore: unused_import
import 'package:prismcart/features/home/widgets/deal_of_day.dart';
import 'package:prismcart/features/home/widgets/top_categories.dart';
import 'package:prismcart/features/product_details/screens/product_details_screen.dart';
import 'package:prismcart/features/search/screens/search_screen.dart';
import 'package:prismcart/models/product.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product>? products;
  final HomeServices homeServices = HomeServices();
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: products);
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await homeServices.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
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
                Container(
                  color: Colors.black12,
                  height: 5,
                ),
                const TopCategories(),
                Container(
                  color: Colors.black12,
                  height: 5,
                ),
                // CarouselImage(),
                // const SizedBox(height: 10),
                // DealOfDay(),
                products == null
                    ? Loader()
                    : GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: products!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 2 / 3,
                        ),
                        itemBuilder: (context, index) {
                          final productData = products![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                ProductDetailsScreen.routeName,
                                arguments: productData,
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      productData.images[0],
                                      height: 180,
                                      width: 180,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    productData.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    productData.description,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    '\$${productData.price.toString()}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.from(
                                          alpha: 1,
                                          red: 0,
                                          green: 128,
                                          blue: 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ));
  }
}
