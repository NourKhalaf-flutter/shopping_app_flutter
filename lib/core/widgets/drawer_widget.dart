import 'package:first/core/constants/app_images.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Drawer(
      backgroundColor: AppColors.white,

      width: 300,
      shape: OutlineInputBorder(borderRadius: .circular(0)),
      child: ListView(
        children: [
          DrawerHeader(
            padding: .all(10),
            child: Column(
              children: [
                Align(
                  alignment: .centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: SvgPicture.asset(AppSvgs.close),
                  ),
                ),
                Spacer(),
                ListTile(
                  contentPadding: .symmetric(horizontal: 0),
                  minLeadingWidth: 60,

                  title: Text(
                     auth.name ?? '',
                    
                    style: AppTextStyles.font14MainSans600,
                  ),
                  subtitle: Text(
                    auth.email ?? '',
                 
                    style: AppTextStyles.font14SecondSans,
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.greylight,
                    child: Text(
                    auth.name?[0].toUpperCase() ?? 'U',
                  
                      style: AppTextStyles.font18MainInter500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {},
            minLeadingWidth: 8,
            title: Text('Categories', style: AppTextStyles.font14MainSans),
            leading: SvgPicture.asset(AppSvgs.arrowRight),
          ),
          listItem(context, 'Sales', '(135 items)'),
          listItem(context, 'New arrivals', ' (285 items)'),
          listItem(context, 'Best sellers', '(642 items)'),
          listItem(context, 'Featured products', '(168 items)'),
          InkWell(
            onTap: () {},
            child: Container(
              width: .infinity,
              margin: EdgeInsets.only(left: 20, top: 40),
              padding: .symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                border: .all(color: AppColors.borderColor),
                borderRadius: .only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppSvgs.notif),
                  SizedBox(width: 10),
                  Text('Notifications', style: AppTextStyles.font16MainSans),
                  Spacer(),
                  Container(
                    padding: .symmetric(vertical: 2, horizontal: 5),
                    decoration: BoxDecoration(
                      borderRadius: .circular(20),
                      color: AppColors.red,
                    ),
                    child: Text('14', style: AppTextStyles.font8WhiteSans700),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: () {},

            child: Container(
              width: .infinity,
              margin: EdgeInsets.only(left: 20),
              padding: .symmetric(vertical: 14, horizontal: 20),
              decoration: BoxDecoration(
                border: .all(color: AppColors.borderColor),
                borderRadius: .only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(AppSvgs.help),
                  SizedBox(width: 10),
                  Text('Support', style: AppTextStyles.font16MainSans),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListTile listItem(BuildContext context, String title, String subTitle) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);

        Navigator.pushNamed(context, RouteNames.arrivalsScreen);
      },
      contentPadding: .symmetric(horizontal: 20),
      minLeadingWidth: 8,
      title: Row(
        mainAxisAlignment: .start,
        children: [
          Text(title, style: AppTextStyles.font14MainSans),
          SizedBox(width: 6),
          Text(subTitle, style: AppTextStyles.font10SecondSans),
        ],
      ),

      leading: SvgPicture.asset(AppSvgs.arrowRight),
    );
  }
}
