import 'package:cached_network_image/cached_network_image.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductItemWidget extends StatelessWidget {
  final String imageUrl;
  const ProductItemWidget(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RouteNames.detailsScreen);
      },
      child: Container(
        margin: .only(right: 14),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 200,
                  height: 250,
                  child: ClipRRect(
                    borderRadius: .circular(5),
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      placeholder: (context, url) => Container(
                        width: 200,
                        height: 250,
                        color: AppColors.placeholderColor,
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 200,
                        height: 250,
                        color: AppColors.placeholderColor,
                      ),

                      width: 200,
                      height: 250,

                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 14,
                  top: 14,
                  child: SvgPicture.asset(AppSvgs.heart),
                ),
                Positioned(
                  right: 14,
                  bottom: 14,
                  child: SvgPicture.asset(AppSvgs.add),
                ),
              ],
            ),
            SizedBox(height: 14),
            Text('Warm winter hat', style: AppTextStyles.font14SecondSans),
            SizedBox(height: 4),
            Text('\$12.7', style: AppTextStyles.font14MainSans),
          ],
        ),
      ),
    );
  }
}
