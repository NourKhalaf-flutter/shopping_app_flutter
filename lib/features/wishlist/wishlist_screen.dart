import 'package:cached_network_image/cached_network_image.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .fromLTRB(20, 20, 0, 20),
      child: ListView.builder(
        itemCount: 3,

        itemBuilder: (_, index) => item(''),
      ),
    );
  }
}

Widget item(String imageUrl) {
  return Container(
    height: 100,
    width: .infinity,
    margin: .only(bottom: 14),

    child: Row(
      children: [
        ClipRRect(
          borderRadius: .only(
            topLeft: Radius.circular(5),
            bottomLeft: Radius.circular(5),
          ),
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Container(
              width: 100,
              height: 100,
              color: AppColors.placeholderColor,
            ),

            errorWidget: (context, url, error) => Container(
              width: 100,
              height: 100,
              color: AppColors.placeholderColor,
            ),

            width: 100,
            height: 100,

            fit: BoxFit.cover,
          ),
        ),
        Expanded(
          child: Container(
            padding: .fromLTRB(14, 14, 20, 14),
            decoration: BoxDecoration(
              border: .fromLTRB(
                left: .none,
                right: .none,
                top: BorderSide(color: AppColors.borderColor),
                bottom: BorderSide(color: AppColors.borderColor),
              ),
            ),
            child: Row(
              children: [
                Column(
                  //mainAxisSize: .min,
                  crossAxisAlignment: .start,
                  mainAxisAlignment: .start,
                  children: [
                    Text(
                      'Modern undershirt',
                      style: AppTextStyles.font14SecondSans,
                    ),
                    Text('SAR 33.7', style: AppTextStyles.font14MainSansW500),
                    Spacer(),
                    Row(
                      mainAxisAlignment: .start,
                      children: [
                        SvgPicture.asset(AppSvgs.star),
                        SizedBox(width: 4),
                        Text('5.0', style: AppTextStyles.font12SecondSans),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(AppSvgs.fillHeart),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(AppSvgs.add),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
