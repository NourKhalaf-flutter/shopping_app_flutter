 
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first/core/constants/app_colors.dart';
import 'package:first/core/constants/app_images.dart';
import 'package:first/core/routes/route_names.dart';
import 'package:first/core/widgets/app_bar_widget.dart';
import 'package:first/features/products/product_model.dart';
import 'package:first/features/products/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ArrivalsScreen extends StatefulWidget {
  const ArrivalsScreen({super.key});

  @override
  State<ArrivalsScreen> createState() => _ArrivalsScreenState();
}

class _ArrivalsScreenState extends State<ArrivalsScreen> {
  String selectedSorting = 'Price: Low to High';
  final List<String> sortingOptions = const [
    'Best match',
    'Price: Low to High',
    'Price: High to Low',
    'Newest',
    'Customer Rating',
    'Most Popular',
  ];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    
   WidgetsBinding.instance.addPostFrameCallback((_) {
    context.read<ProductsProvider>().loadInitialProducts();
  });
   


    // Scroll listener لتحميل المزيد عند الوصول لأسفل
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<ProductsProvider>().loadMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Arrivals', tag: 'arrivals'),
      body: Consumer<ProductsProvider>(
        builder: (context, provider, _) {
   
          if (provider.isLoading && provider.products.isEmpty) {
            // تحميل أول مرة
            return const Center(child: CircularProgressIndicator());
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
                        provider.loadInitialProducts();
                      },
                      child: const Text('Try again'),
                    ),
                  ],
                ),
              );
            }


          if (provider.products.isEmpty) {
            return const Center(child: Text('No products found'));
          }
          return Padding(
            padding: const .all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(AppSvgs.filters),
                    SizedBox(width: 8),
                    Text('Filters'),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (_) => _sortingDialog(context),
                        );
                      },
                      child: Row(
                        children: [
                          const Text('Sorting by'),
                          const SizedBox(width: 8),
                          SvgPicture.asset(AppSvgs.arrowDown),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14),
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                      childAspectRatio: 170 / 310,
                    ),
                    itemCount:
                        provider.products.length +
                        (provider.isLoadingMore ? 1 : 0),
                    itemBuilder: (_, index) {
                      if (index >= provider.products.length) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final product = provider.products[index];
                      return _item(product);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _item(ProductModel product) => InkWell(
    onTap: () {
      Navigator.pushNamed(context, RouteNames.detailsScreen,arguments: product);
    },
    child: Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 170 / 250,
              child: ClipRRect(
                borderRadius: .circular(5),
                child: CachedNetworkImage(
                  imageUrl: product.thumbnailUrl ?? '',
                  placeholder: (context, url) =>
                      Container(color: AppColors.placeholderColor),
                  errorWidget: (context, url, error) =>
                      Container(color: AppColors.placeholderColor),

                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              right: 10,
              top: 10,
              child: SvgPicture.asset(AppSvgs.heart),
            ),
          ],
        ),
        SizedBox(height: 14),
        Text(
          product.name ?? '',
          softWrap: false,
          overflow: .ellipsis,
          style: GoogleFonts.dmSans(color: AppColors.secondColor, fontSize: 14),
        ),
        SizedBox(height: 4),
        Text(
          'SAR ${ product.price ?? '0.0'}' ,
          style: GoogleFonts.dmSans(
            color: AppColors.mainColor,
            fontSize: 14,
            fontWeight: .w500,
          ),
        ),
      ],
    ),
  );

  Widget _sortingDialog(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setDialogState) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: RadioGroup<String>(
              groupValue: selectedSorting,

              onChanged: (value) async {
                setDialogState(() {
                  selectedSorting = value!;
                });

                // setState(() {
                //   selectedSorting = value!;
                // });

                await Future.delayed(const Duration(milliseconds: 100));

                Navigator.pop(context);
              },
              child: Column(
                mainAxisSize: .min,
                children: sortingOptions
                    .map(
                      (option) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Radio<String>(value: option),
                            SizedBox(width: 8),
                            Text(option),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
