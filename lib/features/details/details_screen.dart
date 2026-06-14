
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first/features/cart/cart_provider.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:first/core/widgets/app_bar_widget.dart';
import 'package:first/core/widgets/button_widget.dart';
import 'package:first/features/details/product_details_provider.dart';
import 'package:first/features/details/related_products_provider.dart';
import 'package:first/features/products/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  const DetailsScreen(this.productModel, {super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final PageController _controller = PageController();
  late ProductModel productModel;
  int _currentPage = 0;
  int _itemCount = 1;

  final _sizesList = const ['XS', 'S', 'M', 'L', 'XS', 'XXL'];
  int? _selectedSizeIndex;
  //final List<String> _images = [];

  @override
  void initState() {
    super.initState();

    productModel = widget.productModel;
 
    //---Details---
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final detailsProvider = context.read<ProductDetailsProvider>();
      detailsProvider.setInitialProduct(productModel);
      detailsProvider.loadProductDetails(
        int.tryParse(productModel.productId ?? '') ?? 0,
      );

      //----Related Products----
      final provider = context.read<RelatedProductsProvider>();
      provider.loadProducts(int.tryParse(productModel.productId ?? '') ?? 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(title: '', tag: 'details'),

        body: Consumer<ProductDetailsProvider>(
          builder: (_, detailsProvider, _) => Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 550,
                            width: .infinity,
                            child: Stack(
                              alignment: .bottomCenter,
                              children: [
                                PageView.builder(
                                  controller: _controller,
                                  onPageChanged: (index) {
                                    setState(() {
                                      _currentPage = index;
                                    });
                                  },
                                  itemCount:
                                      detailsProvider.product?.images?.length ??
                                      0,

                                  itemBuilder: (_, index) => CachedNetworkImage(
                                    imageUrl:
                                        detailsProvider
                                            .product
                                            ?.images![index]
                                            .url ??
                                        '',
                                    placeholder: (context, url) => Container(
                                      width: .infinity,
                                      height: 500,
                                      color: AppColors.placeholderColor,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: .infinity,
                                          height: 500,
                                          color: AppColors.placeholderColor,
                                        ),

                                    // width: 200,
                                    // height: 250,

                                   fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  child: Row(
                                    mainAxisSize: .min,
                                    children: List.generate(
                                      detailsProvider.product?.images?.length ??
                                          0,

                                      (i) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                          ),
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: _currentPage == i
                                                ? AppColors.mainColor
                                                : AppColors.white,
                                            border: _currentPage == i
                                                ? null
                                                : .all(
                                                    color:
                                                        AppColors.borderColor,
                                                  ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: 20,
                                  bottom: 24,
                                  child: InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset(AppSvgs.heart),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const .fromLTRB(20, 30, 0, 0),
                            child: Column(
                              crossAxisAlignment: .start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        productModel.name ?? '',
                                        softWrap: true,
                                        
                                        style: AppTextStyles.font20MainInter500.copyWith(height: 1.7),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    SvgPicture.asset(AppSvgs.star),
                                    SizedBox(width: 5),
                                    Text(
                                      '5.0',
                                      style: AppTextStyles.font12SecondSans,
                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                                Container(
                                  width: .infinity,
                                  margin: EdgeInsets.only(top: 30, bottom: 30),
                                  padding: .symmetric(
                                    vertical: 15,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    border: .fromLTRB(
                                      top: BorderSide(
                                        color: AppColors.borderColor,
                                      ),
                                      bottom: BorderSide(
                                        color: AppColors.borderColor,
                                      ),
                                      left: BorderSide(
                                        color: AppColors.borderColor,
                                      ),
                                    ),
                                    borderRadius: .only(
                                      topLeft: Radius.circular(5),
                                      bottomLeft: Radius.circular(5),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'SAR ${productModel.price}',
                                        style: AppTextStyles.font20MainSans700,
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (_itemCount > 1) _itemCount--;
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(20),

                                        child: Container(
                                          padding: .all(12),
                                          child: SvgPicture.asset(
                                            AppSvgs.minus,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 24),
                                      Text(_itemCount.toString()),
                                      SizedBox(width: 24),

                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (_itemCount < 5) _itemCount++;
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(20),

                                        child: Container(
                                          padding: .all(12),
                                          child: SvgPicture.asset(
                                            AppSvgs.add,
                                            colorFilter: ColorFilter.mode(
                                              AppColors.mainColor,
                                              .srcIn,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  'Size',
                                  style: AppTextStyles.font14MainInter600,
                                ),
                                SizedBox(height: 20),
                                SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: .horizontal,
                                    itemCount: _sizesList.length,
                                    separatorBuilder: (_, _) =>
                                        SizedBox(width: 10),
                                    itemBuilder: (_, index) => sizeItem(index),
                                  ),
                                ),
                                SizedBox(height: 30),

                                Text(
                                  'Description',
                                  style: AppTextStyles.font14MainInter600,
                                ),
                                Container(
                                  // height: 162,
                                  margin: .only(top: 20, bottom: 14, right: 20),
                                  child: Text(
                                    detailsProvider.product?.metaDescription ??
                                        '',
                                    overflow: .ellipsis,
                                    softWrap: true,
                                    maxLines: 6,
                                    style: AppTextStyles.font16SecondSans,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      RouteNames.descriptionScreen,
                                      arguments: [
                                        productModel.name,
                                        productModel.description,
                                      ],
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: .min,
                                    children: [
                                      Text(
                                        'read more',
                                        style: AppTextStyles.font16MainSans,
                                      ),
                                      SizedBox(width: 6),
                                      SvgPicture.asset(
                                        AppSvgs.arrowRight,
                                        colorFilter: ColorFilter.mode(
                                          AppColors.mainColor,
                                          .srcIn,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                  padding: .only(
                                    top: 20,
                                    bottom: 14,
                                    right: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Related Products',
                                        style: AppTextStyles.font14MainInter600,
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        child: Row(
                                          children: [
                                            Text(
                                              'view all',
                                              style:
                                                  AppTextStyles.font16MainSans,
                                            ),

                                            SizedBox(width: 6),
                                            SvgPicture.asset(
                                              AppSvgs.arrowRight,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Consumer<RelatedProductsProvider>(
                                  builder: (context, provider, _) {
                                    return SizedBox(
                                      height: 330,
                                      // margin: .only(left: 20),
                                      child: ListView.builder(
                                        itemCount: provider.products.length,
                                        scrollDirection: .horizontal,
                                        itemBuilder: (_, index) =>
                                            item(provider.products[index]),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: .all(20),

                    child: ButtonWidget(
                      content: '+ ADD TO CART',
                      onPressed: () async {
                        final cartProvider = context.read<CartProvider>();
                        await cartProvider.addItem(
                          productModel,
                          quantity: _itemCount,
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${productModel.name} added to cart'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              if (detailsProvider.isLoading)
                Positioned.fill(
                  top: 0,

                  child: Container(
                    // width: .infinity,
                    // height: 500,
                    color: AppColors.black.withAlpha(150),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget item(ProductModel productModel) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteNames.detailsScreen,
          arguments: productModel,
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
                    imageUrl: productModel.image ?? '',
                    placeholder: (context, url) => Container(
                      width: 170,
                      height: 250,
                      color: AppColors.placeholderColor,
                    ),
                    errorWidget: (context, url, error) => Container(
                      width:170,
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
              productModel.name ?? '',
              overflow: .ellipsis,
              style: AppTextStyles.font14SecondSans,
            ),
            SizedBox(height: 4),
            Text(
           '${productModel.price }',
              style: AppTextStyles.font14MainSansW500,
            ),
          ],
        ),
      ),
    );
  }

  Widget sizeItem(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedSizeIndex = index;
        });
      },
      child: Container(
        height: 40,
        width: 40,
        // padding: .symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: .all(color: AppColors.borderColor),
          borderRadius: .circular(3),
          color: _selectedSizeIndex == index
              ? AppColors.mainColor
              : AppColors.lightFillColor,
        ),
        child: Center(
          child: Text(
            _sizesList[index],
            style: AppTextStyles.font12WhiteSans700.copyWith(
              color: _selectedSizeIndex == index
                  ? Colors.white
                  : AppColors.mainColor,
            ),
          ),
        ),
      ),
    );
  }
}
