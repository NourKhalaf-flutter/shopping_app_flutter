import 'package:first/core/di/injection_container.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/core/services/app_preferences.dart';
import 'package:first/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  late AppPreferences appPreferences;
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome To Kastelli!',
      'body': 'Labore sunt culpa excepteur culpa occaecat ex nisi mollit.',
    },
    {
      'title': 'Easy Track\nyour Order!',
      'body': 'Labore sunt culpa excepteur culpa occaecat ex nisi mollit.',
    },
    {
      'title': 'Door to Door\nDelivery!',
      'body': 'Labore sunt culpa excepteur culpa occaecat ex nisi mollit.',
    },
  ];
@override
void initState() {
  super.initState();
  appPreferences = sl<AppPreferences>();
}
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50.0, 20, 20),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              SizedBox(
                height: 220,
                width: .infinity,
                child: PageView.builder(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _pages.length,
                  itemBuilder: (_, index) => Column(
                    crossAxisAlignment: .start,
                    mainAxisSize: .min,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          _pages[index]['title']!,
                          style: AppTextStyles.font32MainInter700,
                        ),
                      ),
                      SizedBox(height: 14),
                      SizedBox(
                        width: 200,
                        child: Text(
                          _pages[index]['body']!,
                          style: AppTextStyles.font16SecondSans,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: List.generate(_pages.length, (i) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 20,
                    ),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == i
                          ? AppColors.mainColor
                          : AppColors.secondColor.withAlpha(38),
                    ),
                  );
                }),
              ),
              Spacer(),
              ButtonWidget(
                content: 'Get Start',
                onPressed: () async{
                await appPreferences.setOnboardingCompleted(true);
                Navigator.pushNamed(context, RouteNames.loginScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
