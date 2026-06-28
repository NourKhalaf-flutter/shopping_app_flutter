import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/widgets/outlined_button_widget.dart';
import 'package:first/features/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return SingleChildScrollView(
      child: Padding(
        padding: const .only(top: 50, bottom: 20),
        child: Column(
          children: [
            ListTile(
              contentPadding: .symmetric(horizontal: 20),
              minLeadingWidth: 60,

              title: Text(
               auth.name ?? '',
               
                style: AppTextStyles.font14MainInter600,
              ),
              subtitle: Text(
               auth.email ?? '',
               
                style: AppTextStyles.font14SecondSans,
              ),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.greylight,
                child: Text(
                //  auth.name?[0].toUpperCase() ?? 'U',
                  'N',
                  style: AppTextStyles.font18MainInter500,
                ),
              ),
              trailing: InkWell(
                onTap: () {},
                borderRadius: .circular(20),
                child: Container(
                  padding: .all(12),
                  child: SvgPicture.asset(AppSvgs.edit),
                ),
              ),
            ),
            SizedBox(height: 30),
            OutlinedButtonWidget(
              'My orders',
              () {},
              leading: AppSvgs.order,
              trailing: AppSvgs.arrowRight,
            ),
            OutlinedButtonWidget(
              'Payment method',
              () {},
              leading: AppSvgs.payment,
              trailing: AppSvgs.arrowRight,
            ),
            OutlinedButtonWidget(
              'Delivery address',
              () {},
              leading: AppSvgs.map,
              trailing: AppSvgs.arrowRight,
            ),
            OutlinedButtonWidget(
              'Promocodes & gift cards',
              () {},
              leading: AppSvgs.gift,
              trailing: AppSvgs.arrowRight,
            ),
            OutlinedButtonWidget('Sign out', () async {
              await context.read<AuthProvider>().logout();
              Navigator.pushNamedAndRemoveUntil(
                context,
                RouteNames.loginScreen,
                (route) => false,
              );
            }, leading: AppSvgs.logout),
          ],
        ),
      ),
    );
  }
}
