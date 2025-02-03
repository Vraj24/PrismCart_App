import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay/pay.dart';
import 'package:prismcart/common/widgets/custom_textfield.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/constants/utils.dart';
import 'package:prismcart/features/address/services/address_services.dart';
import 'package:prismcart/providers/user_provider.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  final String totalAmount;
  static const String routeName = '/address';
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressTobeUsed = "";
  List<PaymentItem> paymentItems = [];
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
          amount: widget.totalAmount,
          label: "Total Amount",
          status: PaymentItemStatus.final_price),
    );
  }

  @override
  void dispose() {
    flatBuildingController.dispose();
    areaController.dispose();
    pinCodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  void onApplePayResult(paymentResult) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressTobeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressTobeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void onGooglePayResult(res) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressTobeUsed);
    }
    addressServices.placeOrder(
      context: context,
      address: addressTobeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFormProvider) {
    addressTobeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressTobeUsed =
            '${areaController.text}, ${flatBuildingController.text}, ${cityController.text} - ${pinCodeController.text}';
      } else {
        throw Exception('Please enter correct address!');
      }
    } else if (addressFormProvider.isNotEmpty) {
      addressTobeUsed = addressFormProvider;
    } else {
      showSnackBar(context, 'ERROR');
    }
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.grayBackgroundColor),
          ),
          title: Row(children: [
            Image(
              image: AssetImage('assets/images/favicon.png'),
              width: 40,
              height: 40,
            ),
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Text(
                "PrismCart",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ]),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: GlobalVariables.backgroundGradient,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (address.isNotEmpty)
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            address,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "OR",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: areaController,
                        hintText: 'Area/Street',
                      ),
                      const SizedBox(height: 20),
                      CustomTextfield(
                        controller: flatBuildingController,
                        hintText: 'Flat, House No., Building',
                      ),
                      const SizedBox(height: 20),
                      CustomTextfield(
                        controller: cityController,
                        hintText: 'City',
                      ),
                      const SizedBox(height: 20),
                      CustomTextfield(
                        controller: pinCodeController,
                        hintText: 'Pin Code',
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                FutureBuilder<String>(
                  future: rootBundle.loadString('assets/applepay.json'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading Apple Pay configuration');
                    } else {
                      return ApplePayButton(
                        onPressed: () => payPressed(address),
                        width: 150,
                        height: 40,
                        type: ApplePayButtonType.buy,
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(snapshot.data!),
                        paymentItems: paymentItems,
                        onPaymentResult: onApplePayResult,
                      );
                    }
                  },
                ),
                const SizedBox(height: 10),
                FutureBuilder<String>(
                  future: rootBundle.loadString('assets/gpay.json'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading Google Pay configuration');
                    } else {
                      return GooglePayButton(
                        onPressed: () => payPressed(address),
                        // width: 200,
                        // height: 40,
                        type: GooglePayButtonType.buy,
                        paymentConfiguration:
                            PaymentConfiguration.fromJsonString(snapshot.data!),
                        paymentItems: paymentItems,
                        onPaymentResult: onGooglePayResult,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
