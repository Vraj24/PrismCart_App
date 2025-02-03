import 'package:flutter/material.dart';
import 'package:prismcart/common/widgets/custom_button.dart';
import 'package:prismcart/common/widgets/custom_textfield.dart';
import 'package:prismcart/constants/global_variables.dart';
import 'package:prismcart/features/auth/services/auth_service.dart';

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  final AuthService authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      address: _addressController.text,
      phone: _phoneController.text,
      answer: _answerController.text,
    );
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.grayBackgroundColor),
          ),
          title: Row(
            children: [
              Image(
                image: AssetImage('assets/images/favicon.png'),
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 93),
              Text(
                "PrismCart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: GlobalVariables.backgroundGradient,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    tileColor: _auth == Auth.signup
                        ? GlobalVariables.backgroundColor
                        : GlobalVariables.grayBackgroundColor,
                    title: const Text(
                      "Create an account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signup,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      },
                    ),
                  ),
                  if (_auth == Auth.signup)
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      // color: GlobalVariables.backgroundColor,
                      child: Form(
                        key: _signUpFormKey,
                        child: Column(
                          children: [
                            CustomTextfield(
                              controller: _nameController,
                              hintText: 'Name',
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              controller: _passwordController,
                              hintText: 'Password',
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              controller: _addressController,
                              hintText: 'Address',
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              controller: _phoneController,
                              hintText: 'Phone No.',
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              controller: _answerController,
                              hintText: 'Birth Place',
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                                text: "Sign Up",
                                onTap: () {
                                  if (_signUpFormKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                  ListTile(
                    tileColor: _auth == Auth.signin
                        ? GlobalVariables.backgroundColor
                        : GlobalVariables.grayBackgroundColor,
                    title: const Text(
                      "Sign in",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    leading: Radio(
                      activeColor: GlobalVariables.secondaryColor,
                      value: Auth.signin,
                      groupValue: _auth,
                      onChanged: (Auth? val) {
                        setState(() {
                          _auth = val!;
                        });
                      },
                    ),
                  ),
                  if (_auth == Auth.signin)
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      // color: GlobalVariables.backgroundColor,
                      child: Form(
                        key: _signInFormKey,
                        child: Column(
                          children: [
                            CustomTextfield(
                              controller: _emailController,
                              hintText: 'Email',
                            ),
                            const SizedBox(height: 20),
                            CustomTextfield(
                              controller: _passwordController,
                              hintText: 'Password',
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                                text: "Sign In",
                                onTap: () {
                                  if (_signInFormKey.currentState!.validate()) {
                                    signInUser();
                                  }
                                })
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
