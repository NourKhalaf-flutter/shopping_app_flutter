import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/core/widgets/app_bar_widget.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  final String title, description;
  const DescriptionScreen(this.title, this.description, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Description', tag: 'Description'),
      body: Padding(
        padding: const .fromLTRB(20, 55, 20, 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(title, style: AppTextStyles.font20MainInter500),
              SizedBox(height: 14),
              Text(description, style: AppTextStyles.font16SecondSans),
            ],
          ),
        ),
      ),
    );
  }
}
