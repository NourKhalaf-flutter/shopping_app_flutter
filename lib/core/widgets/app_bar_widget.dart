import 'package:first/features/cart/cart_provider.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/constants/app_text_styles.dart';
 import 'package:first/core/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title, tag;
  const AppBarWidget({super.key, required this.title, required this.tag});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(1),
        child: Container(color: AppColors.borderColor, height: 1),
      ),
      leading: Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              if (tag == 'main') {
                Scaffold.of(context).openDrawer();
              } else {
                Navigator.pop(context);
              }
            },
            icon: SvgPicture.asset(
              tag == 'main' ? AppSvgs.menu : AppSvgs.arrowLeft,
            ),
          );
        },
      ),
      actions: [
        Consumer<CartProvider>(
          builder: (_, cartprovider, _) => InkWell(
            onTap: () {
             Navigator.pushNamed(context, RouteNames.mainScreen,arguments: 2);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: .circular(30),
                      color: AppColors.mainColor,
                    ),
                    child: Text(
                      '${cartprovider.itemCount}',
                      style: AppTextStyles.font10WhiteSans700,
                    ),
                  ),
                  SvgPicture.asset(AppSvgs.cart),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
