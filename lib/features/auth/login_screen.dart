import 'package:first/core/constants/app_images.dart';
import 'package:first/core/notifications/notification_service.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/core/utils/validators.dart';
import 'package:first/core/widgets/button_widget.dart';
import 'package:first/core/widgets/text_form_field.dart';
import 'package:first/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isHide = true, _isChecked = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {},
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 87, 20, 20),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: AppTextStyles.font32MainInter700,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'sign in to continue',
                    style: AppTextStyles.font16SecondSans,
                  ),
                  SizedBox(height: 30),
                  TextFormFieldWidget(
                    controller: _emailController,
                    label: 'EMAIL',
                    validator: (value) => Validators.validateEmail(
                      value,
                      'Please enter your email',
                      'Please enter a valid email address.',
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormFieldWidget(
                    label: 'PASSWORD',
                    controller: _passwordController,
                    validator: (value) => Validators.validatePassword(
                      value,
                      'Please enter your password',
                      'The password should be at least 8 characters',
                    ),
                    obscureText: isHide,
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isHide = !isHide;
                          });
                        },
                        icon: Icon(
                          isHide
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Checkbox(
                        value: _isChecked,
                        onChanged: (isChecked) {
                          setState(() {
                            _isChecked = isChecked!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        side: const BorderSide(
                          color: AppColors.borderColor,
                          width: 1,
                        ),

                        fillColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.selected)) {
                            return AppColors.mainColor;
                          }
                          return Color(0x33DBE9F5);
                        }),
                      ),
                      Text(
                        'Remember me',
                        style: AppTextStyles.font14SecondSans,
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RouteNames.forgotPasswordScreen,
                          );
                        },
                        child: Text(
                          'Forgot password?',
                          style: AppTextStyles.font16MainSans,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Consumer<AuthProvider>(
                    builder:
                        (BuildContext context, authProvider, Widget? child) {
                          return authProvider.isLoading
                              ? Center(child: CircularProgressIndicator())
                              : ButtonWidget(
                                  content: 'SIGN IN',
                                  onPressed: () async {
                                    if (!_formKey.currentState!.validate()) {
                                      return;
                                    }

                                    final email = _emailController.text.trim();
                                    final password = _passwordController.text;

                                    await authProvider.login(email, password);
                                    
                                    if (authProvider.isLoggedIn) {
                                      NotificationService().showNotification(
                                        title: 'Success Login',
                                        body: 'Welcome, start shopping now!',
                                      );

                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouteNames.mainScreen,

                                        (route) => false,
                                      );
                                    } else if (authProvider.errorMessage !=
                                        null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            authProvider.errorMessage!,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                        },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: AppTextStyles.font16SecondSans,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Sign up.',
                          style: AppTextStyles.font16MainSans,
                        ),
                      ),
                    ],
                  ),
                  // Spacer(),
                  SizedBox(height: 30),
                  Container(
                    width: .infinity,
                    decoration: BoxDecoration(
                      border: .all(color: AppColors.borderColor),
                      borderRadius: .circular(5),
                    ),
                    height: 50,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(AppSvgs.google),
                      label: Text(
                        'SIGN IN With GOOGLE',
                        style: GoogleFonts.dmSans(
                          color: AppColors.secondColor,
                          fontWeight: .bold,
                        ),
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
