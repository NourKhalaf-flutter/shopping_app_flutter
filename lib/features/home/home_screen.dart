import 'package:cached_network_image/cached_network_image.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/core/widgets/button_secondry_widget.dart';
import 'package:first/features/products/product_model.dart';
import 'package:first/features/products/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductsProvider>().getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Consumer<ProductsProvider>(
          builder: (_, provider, _) {
            if (provider.isLoading) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 160,

                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (provider.errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      provider.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        provider.getProducts();
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 160,

                  child: Stack(
                    alignment: .bottomCenter,
                    children: [
                      CachedNetworkImage(
                        imageUrl: provider.bestProducts[0].images![0].url,
                        placeholder: (context, url) => Container(
                          color: AppColors.placeholderColor,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 160,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.placeholderColor,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 160,
                        ),

                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 160,

                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 80,
                        child: Container(
                          width: 350,
                          height: 130,

                          padding: .all(20),
                          decoration: BoxDecoration(
                            borderRadius: .circular(5),
                            color: AppColors.white.withAlpha(150),
                          ),
                          margin: .symmetric(horizontal: 40),
                          child: Column(
                            mainAxisSize: .min,
                            crossAxisAlignment: .center,
                            children: [
                              Text(
                                'Up to 30% OFF',
                                style: AppTextStyles.font20MainSans700,
                              ),
                              SizedBox(height: 8),
                              ButtonSecondryWidget(
                                content: 'Shop now',
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),

                cachedImage(provider.bestProducts[3].images![0].url),
                cachedImage(provider.bestProducts[8].images![0].url),
                Container(
                  padding: .symmetric(vertical: 14, horizontal: 20),
                  child: Row(
                    children: [
                      Text(
                        'Best Sellers',
                        style: AppTextStyles.font20MainInter500,
                      ),
                      Spacer(),
                      GestureDetector(
                        child: Row(
                          children: [
                            Text(
                              'view all',
                              style: AppTextStyles.font16MainSans,
                            ),

                            SizedBox(width: 6),
                            SvgPicture.asset(AppSvgs.arrowRight),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 330,
                  margin: .only(left: 20),
                  child: ListView.builder(
                    itemCount: provider.bestProducts.length,
                    scrollDirection: .horizontal,
                    itemBuilder: (_, index) =>
                        item(provider.bestProducts[index]),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget item(ProductModel product) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.detailsScreen,
          arguments: product,
        );
      },
      child: Container(
        width: 170,
        margin: .only(right: 14),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: .circular(5),
                  child: CachedNetworkImage(
                    imageUrl: product.thumbnailUrl ?? '',
                    placeholder: (context, url) => Container(
                      width: 170,
                      height: 250,
                      color: AppColors.placeholderColor,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 170,
                      height: 250,
                      color: AppColors.placeholderColor,
                    ),

                    width: 170,
                    height: 250,

                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 14,
                  top: 14,
                  child: SvgPicture.asset(AppSvgs.heart),
                ),
              ],
            ),
            SizedBox(height: 14),
            Text(
              product.name ?? '',
              overflow: .ellipsis,
              style: AppTextStyles.font14SecondSans,
            ),
            SizedBox(height: 4),
            Text(
              'SAR ${product.price ?? ''}',
              style: AppTextStyles.font14MainSansW500,
            ),
          ],
        ),
      ),
    );
  }

  Widget cachedImage(String url) {
    return Container(
      margin: .only(bottom: 8),
      child: CachedNetworkImage(
        imageUrl: url,
        placeholder: (context, url) => Container(
          width: .infinity,
          height: 600,
          color: AppColors.placeholderColor,
        ),
        errorWidget: (context, url, error) => Container(
          width: .infinity,
          height: 600,
          color: AppColors.placeholderColor,
        ),

        width: .infinity,
        height: 600,

        fit: BoxFit.cover,
      ),
    );
  }
}
