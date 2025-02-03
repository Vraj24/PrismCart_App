import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prismcart/common/widgets/custom_button.dart';
import 'package:prismcart/common/widgets/stars.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/features/product_details/services/product_details_services.dart';
import 'package:prismcart/features/search/screens/search_screen.dart';
import 'package:prismcart/models/product.dart';
import 'package:prismcart/providers/user_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  double avgRating = 0;
  double myRating = 0;

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
      }
    }

    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
    SnackBar(
      content: Text("Item added in Cart"),
    );
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
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: GlobalVariables.backgroundGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stars(rating: avgRating),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Text(
                  widget.product.name,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.product.description),
              ),
              CarouselSlider(
                items: widget.product.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 200,
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 300,
                ),
              ),
              Container(
                color: Colors.black12,
                height: 3,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: RichText(
                  text: TextSpan(
                    text: 'Price: ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: '\$${widget.product.price}',
                        style: const TextStyle(
                          fontSize: 22,
                          color:
                              Color.from(alpha: 1, red: 0, green: 128, blue: 0),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black12,
                height: 3,
              ),
              Center(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(
                    text: 'Buy Now',
                    color: Color.fromRGBO(13, 202, 240, 1),
                    onTap: () {},
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(10),
                  child: CustomButton(
                    text: 'Add to Cart',
                    onTap: addToCart,
                    color: const Color.fromRGBO(33, 37, 41, 1),
                  ),
                ),
              ),
              Container(
                color: Colors.black12,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'Rate The Product',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              RatingBar.builder(
                  initialRating: myRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: GlobalVariables.secondaryColor,
                      ),
                  onRatingUpdate: (rating) {
                    productDetailsServices.rateProduct(
                      context: context,
                      product: widget.product,
                      rating: rating,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
