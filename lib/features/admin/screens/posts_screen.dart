import 'package:flutter/material.dart';
import 'package:prismcart/common/widgets/loader.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/features/admin/screens/add_product_screen.dart';
import 'package:prismcart/features/admin/services/admin_services.dart';
import 'package:prismcart/models/product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  List<Product>? products;
  final AdminServices adminServices = AdminServices();
  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  void navigateToAddproduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: GlobalVariables.backgroundGradient,
              ),
              child: GridView.builder(
                padding: EdgeInsets.only(top: 4),
                shrinkWrap: true,
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Container(
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
                            width: 180,
                            height: 180,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          productData.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          productData.description,
                          overflow: TextOverflow.ellipsis,
                          // maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Qty: ${productData.quantity.toString()}',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Text(
                                '\$${productData.price.toString()}',
                                style: TextStyle(
                                  color: Color.from(
                                      alpha: 1, red: 0, green: 128, blue: 0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () =>
                                  deleteProduct(productData, index),
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: GlobalVariables.backgroundGradient.colors.first,
              foregroundColor: Colors.black,
              onPressed: navigateToAddproduct,
              tooltip: 'Add a Product',
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
