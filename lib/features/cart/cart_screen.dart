import 'package:cached_network_image/cached_network_image.dart';
import 'package:first/features/cart/cart_model.dart';
import 'package:first/features/cart/cart_provider.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (_, provider, _) {
        if (provider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: .fromLTRB(20, 20, 0, 20),
          child: provider.items.isEmpty
              ? Column(
                  crossAxisAlignment: .start,
                  children: [
                    SizedBox(height: 148),
                    SvgPicture.asset(AppSvgs.emptyCart),
                    Spacer(),
                    Container(
                      margin: .only(right: 20),
                      width: .infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.borderColor.withAlpha(38),
                        border: .all(color: AppColors.secondColor),
                      ),
                      child: TextButton(
                        onPressed: () {},

                        child: Text(
                          'Shop Now'.toUpperCase(),
                          style: AppTextStyles.font14MainSans700,
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: provider.items.length,

                        itemBuilder: (_, index) {
                          final cartList = provider.items.entries.toList();
                          final id = cartList[index].key;
                          final itemModel = cartList[index].value;

                          return item(itemModel, id);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8, right: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.borderColor.withAlpha(38),
                        border: .all(color: AppColors.borderColor),
                      ),
                      padding: .all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Subtotal',
                                style: AppTextStyles.font14MainInter600,
                              ),
                              Spacer(),
                              Text(
                                'SAR ${provider.totalPrice}',
                                style: AppTextStyles.font14MainSans,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Delivery',
                                style: AppTextStyles.font14SecondSans,
                              ),
                              Spacer(),
                              Text(
                                'SAR 15',
                                style: AppTextStyles.font14SecondSans,
                              ),
                            ],
                          ),
                          SizedBox(height: 14),
                          Divider(color: AppColors.borderColor),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'Total',
                                style: AppTextStyles.font18MainInter500,
                              ),
                              Spacer(),
                              Text(
                                'SAR ${provider.totalPrice + 15}',
                                style: AppTextStyles.font18MainInter500,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: .only(right: 20),
                      width: .infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.borderColor.withAlpha(38),
                        border: .all(color: AppColors.secondColor),
                      ),
                      child: TextButton(
                        onPressed: () {},

                        child: Text(
                          'proceed to checkout'.toUpperCase(),
                          style: AppTextStyles.font14MainSans700,
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

Widget item(CartModel cartModel, String id) {
  return Consumer<CartProvider>(
    builder: (context, provider, _) => Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: AppColors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SvgPicture.asset(AppSvgs.delete),
      ),
      onDismissed: (direction) async {
        await provider.removeItem(id);
      },
      child: Container(
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
                imageUrl: cartModel.image,
                placeholder: (context, url) => Container(
                  width:60,
                  height: 100,
                  color: AppColors.placeholderColor,
                ),

                errorWidget: (context, url, error) => Container(
                  width:60,
                  height: 100,
                  color: AppColors.placeholderColor,
                ),

                width: 60,
                height: 100,

                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: .fromLTRB(14, 0, 20, 0),
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
                    Padding(
                      padding: .only(top: 14, bottom: 14),
                      child: SizedBox(
                        width: 170,
                        child: Column(
                          //mainAxisSize: .min,
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .start,
                          children: [
                            Text(
                              cartModel.name,
                              overflow: .ellipsis,
                              style: AppTextStyles.font14SecondSans,
                            ),
                            Text(
                              ' SAR ${cartModel.price}',
                              style: AppTextStyles.font14MainSansW500,
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: .start,
                              children: [
                                Text(
                                  'Color: blue',
                                  style: AppTextStyles.font12SecondSans,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        InkWell(
                          onTap: () async {
                            if (cartModel.quantity < 5) {
                              await provider.updateQuantity(
                                id,
                                cartModel.quantity + 1,
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: .all(12),
                            child: SvgPicture.asset(AppSvgs.add),
                          ),
                        ),
                        Text('${cartModel.quantity}'),
                        InkWell(
                          onTap: () async {
                            if (cartModel.quantity > 1) {
                              await provider.updateQuantity(
                                id,
                                cartModel.quantity - 1,
                              );
                            }
                          },
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            padding: .all(12),
                            child: SvgPicture.asset(AppSvgs.minus),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
