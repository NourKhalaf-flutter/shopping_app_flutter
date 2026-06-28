import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/core/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password', style: AppTextStyles.font16MainSans),

        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Please enter your email address. You will receive a link to create a new password via email.',
                style: AppTextStyles.font16SecondSans,
              ),
              SizedBox(height: 30),
              Form(
                key: formKey,
                child: TextFormFieldWidget(
                  controller: emailController,
                  label: 'EMAIL',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: .infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.mainColor, AppColors.black],
                  ),
                  borderRadius: .circular(5),
                ),
                height: 50,
                child: TextButton(
                  onPressed: () {},

                  child: Text('SEND', style: AppTextStyles.font14WhiteSans700),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
