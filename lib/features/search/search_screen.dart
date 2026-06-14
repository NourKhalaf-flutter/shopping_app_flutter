 import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/features/search/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<CategoryModel> categories = [
    CategoryModel(name: "Dresses", count: "320", url: 'assets/image/1.png'),
    CategoryModel(name: "Tops", count: "180", url: 'assets/image/2.png'),
    CategoryModel(name: "Bottoms", count: "210", url: 'assets/image/3.png'),
    CategoryModel(name: "Outwear", count: "95", url: 'assets/image/6.png'),
    CategoryModel(name: "Activewear", count: "160", url: 'assets/image/4.png'),
    CategoryModel(name: "Loungwear", count: "75", url: 'assets/image/5.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        children: [
          Container(
            margin: .only(bottom: 15),
            padding: .symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: .circular(5),
              border: Border.all(color: AppColors.borderColor, width: 1),
            ),
            child: Row(
              children: [
                SvgPicture.asset(AppSvgs.search),
                SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: .none,
                      hintText: 'Search',
                      hintStyle: AppTextStyles.font16SecondSans,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: categories.length,
              itemBuilder: (_, index) => item(categories[index]),
            ),
          ),
        ],
      ),
    );
  }
}

Widget item(CategoryModel category) {
  return SizedBox(
    width: 165,
    height: 165,

    child: Stack(
      children: [
        ClipRRect(
          borderRadius: .circular(5),
          child: Image.asset(
            category.url,
            width: 165,
            height: 165,

            // fit: BoxFit.cover,
          ),
        ),
        Positioned(
          left: 14,
          bottom: 14,
          child: Text(
           ' ${category.name}'  ,
            style: AppTextStyles.font14MainSansW500.copyWith(
              color: AppColors.white,
              backgroundColor: AppColors.mainColor.withAlpha(125),

            ),
          ),
        ),
        Positioned(
          left: 14,
          top: 14,
          child: Container(
            padding: .symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: .circular(3),
              color: AppColors.white,
              border: .all(color: AppColors.borderColor),
            ),
            child: Text(category.count, style: AppTextStyles.font16SecondSans),
          ),
        ),
      ],
    ),
  );
}

// Widget item(CategoryModel category) {
//   return Container(
//     width: 165,
//     height: 165,

//     child: Stack(
//       children: [
//         ClipRRect(
//           borderRadius: .circular(5),
//           child: CachedNetworkImage(
//             imageUrl: category.url,
//             placeholder: (context, url) => Container(
//               width: 165,
//               height: 165,
//               color: AppColors.placeholderColor,
//             ),
//             errorWidget: (context, url, error) => Container(
//               width: 165,
//               height: 165,
//               color: AppColors.placeholderColor,
//             ),

//             width: 165,
//             height: 165,

//             fit: BoxFit.cover,
//           ),
//         ),
//         Positioned(
//           left: 14,
//           bottom: 14,
//           child: Text(category.name, style: AppTextStyles.font14MainSansW500),
//         ),
//         Positioned(
//           left: 14,
//           top: 14,
//           child: Container(
//             padding: .symmetric(horizontal: 8),
//             decoration: BoxDecoration(
//               borderRadius: .circular(3),
//               color: AppColors.white,
//               border: .all(color: AppColors.borderColor),
//             ),
//             child: Text(category.count, style: AppTextStyles.font16SecondSans),
//           ),
//         ),
//       ],
//     ),
//   );
// }
