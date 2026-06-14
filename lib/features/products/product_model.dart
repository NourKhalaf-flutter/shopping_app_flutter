class ProductModel {
  String? productId;
  String? sku;
  String? name;
  String? special;
  String? price;
  String? productType;
  String? status;
  String? thumbnailUrl;
  List<ProductImageModel>? images;
  List<String>? label;
  String? currency;
  bool? manufacturer;
  String? discountPercentage;
  dynamic quantity;
  dynamic rating;
  String? minimum;
  String? maximum;
  String? description;
  int? isBuyThisLook;
  int? isRelatedProducts;
  bool? isNew;
  bool? isExclusive;
  bool? isBestseller;
  bool? showLabel;
  String? insiderCategoryId;
  String? insiderCategoryLabel;
  String? baseCurrency;
  String? baseCurrencyPrice;
  String? baseCurrencySpecialPrice;

  //---Related Product---
  String? image;
  bool? freeShipping;
  String? priceWithoutVat;
  String? isReturnable;

  //---Details---

  String? metaDescription;

  String? metaKeyword;

  String? hasOptions;

  String? shippingCountry;

  List<Options>? options;
  List<Attributes>? attributes;

  String? manufacturerId;
  String? brandName;
  String? brandImage;
  String? sizeGuide;
  String? shareText;
  String? shareUrl;
  String? taxClassId;
  String? weight;
  String? length;
  String? width;
  String? height;
  int? reviews;
  String? dateAdded;
  String? dateModified;
  String? categoryName;
  String? masterCategoryId;
  String? flashsaleSpecial;
  String? tamaraLink;
  String? tamaraText;
  String? tamaraSubText;
  bool? isShowTabbyLabel;
  String? preOrderText;
  bool? preOrderItem;
  String? preOrderNote;
  bool? isOutOfStock;
  String? outOfStockText;

  ProductModel({
    this.productId,
    this.sku,
    this.name,
    this.special,
    this.price,
    this.productType,
    this.status,
    this.thumbnailUrl,
    this.images,
    this.label,
    this.currency,
    this.manufacturer,
    this.discountPercentage,
    this.quantity,
    this.rating,
    this.minimum,
    this.maximum,
    this.description,
    this.isBuyThisLook,
    this.isRelatedProducts,
    this.isNew,
    this.isExclusive,
    this.isBestseller,
    this.showLabel,
    this.insiderCategoryId,
    this.insiderCategoryLabel,
    this.baseCurrency,
    this.baseCurrencyPrice,
    this.baseCurrencySpecialPrice,
    //
    this.image,
    this.freeShipping,
    this.priceWithoutVat,
    this.isReturnable,

    //
    this.metaDescription,

    this.metaKeyword,

    this.hasOptions,

    this.shippingCountry,

    this.options,
    this.attributes,

    this.manufacturerId,
    this.brandName,
    this.brandImage,
    this.sizeGuide,
    this.shareText,
    this.shareUrl,
    this.taxClassId,
    this.weight,
    this.length,
    this.width,
    this.height,
    this.reviews,
    this.dateAdded,
    this.dateModified,
    this.categoryName,
    this.masterCategoryId,
    this.flashsaleSpecial,
    this.tamaraLink,
    this.tamaraText,
    this.tamaraSubText,
    this.isShowTabbyLabel,
    this.preOrderText,
    this.preOrderItem,
    this.preOrderNote,
    this.isOutOfStock,
    this.outOfStockText,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['product_id'],
      sku: json['sku'],
      name: json['name'],
      special: json['special'],
      price: json['price'],
      productType: json['product_type'],
      status: json['status'],
      thumbnailUrl: json['thumbnail_url'],

      /// ✅ images
     images: (json['images'] as List?)?.map((e) => ProductImageModel.fromJson(e)).toList(),


      /// ✅ label (List<String>)
      label: (json['label'] as List?)?.map((e) => e.toString()).toList(),

      currency: json['currency'],
      manufacturer: json['manufacturer'],
      discountPercentage: json['discount_percentage'],
      quantity: json['quantity'],
      rating: json['rating'],
      minimum: json['minimum'],
      maximum: json['maximum'],
      description: json['description'],
      isBuyThisLook: json['is_buy_this_look'],
      isRelatedProducts: json['is_related_products'],
      isNew: json['is_new'],
      isExclusive: json['is_exclusive'],
      isBestseller: json['is_bestseller'],
      showLabel: json['show_label'],
      insiderCategoryId: json['insider_category_id'],
      insiderCategoryLabel: json['insider_category_label'],
      baseCurrency: json['base_currency'],
      baseCurrencyPrice: json['base_currency_price'],
      baseCurrencySpecialPrice: json['base_currency_special_price'],
      image: json['image'],
      freeShipping: json['free_shipping'],
      priceWithoutVat: json['price_without_vat'],
      isReturnable: json['is_returnable'],
      //
      metaDescription: json['meta_description'],
      metaKeyword: json['meta_keyword'],
      hasOptions: json['has_options'],
      shippingCountry: json['shipping_country'],

      options: (json['options'] as List?)
          ?.map((e) => Options.fromJson(e))
          .toList(),

      attributes: (json['attributes'] as List?)
          ?.map((e) => Attributes.fromJson(e))
          .toList(),

      manufacturerId: json['manufacturer_id'],
      brandName: json['brand_name'],
      brandImage: json['brand_image'],
      sizeGuide: json['size_guide'],
      shareText: json['share_text'],
      shareUrl: json['share_url'],
      taxClassId: json['tax_class_id'],
      weight: json['weight'],
      length: json['length'],
      width: json['width'],
      height: json['height'],
      reviews: json['reviews'],
      dateAdded: json['date_added'],
      dateModified: json['date_modified'],
      categoryName: json['category_name'],
      masterCategoryId: json['master_category_id'],
      flashsaleSpecial: json['flashsale_special'],
      tamaraLink: json['tamara_link'],
      tamaraText: json['tamara_text'],
      tamaraSubText: json['tamara_sub_text'],
      isShowTabbyLabel: json['is_show_tabby_label'],
      preOrderText: json['pre_order_text'],
      preOrderItem: json['pre_order_item'],
      preOrderNote: json['pre_order_note'],
      isOutOfStock: json['is_out_of_stock'],
      outOfStockText: json['out_of_stock_text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productId,
      'sku': sku,
      'name': name,
      'special': special,
      'price': price,
      'product_type': productType,
      'status': status,
      'thumbnail_url': thumbnailUrl,
      'images': images,
      'label': label,
      'currency': currency,
      'manufacturer': manufacturer,
      'discount_percentage': discountPercentage,
      'quantity': quantity,
      'rating': rating,
      'minimum': minimum,
      'maximum': maximum,
      'description': description,
      'is_buy_this_look': isBuyThisLook,
      'is_related_products': isRelatedProducts,
      'is_new': isNew,
      'is_exclusive': isExclusive,
      'is_bestseller': isBestseller,
      'show_label': showLabel,
      'insider_category_id': insiderCategoryId,
      'insider_category_label': insiderCategoryLabel,
      'base_currency': baseCurrency,
      'base_currency_price': baseCurrencyPrice,
      'base_currency_special_price': baseCurrencySpecialPrice,
      'image': image,
      'free_shipping': freeShipping,
      'price_without_vat': priceWithoutVat,
      'is_returnable': isReturnable,
      //
      'meta_description': metaDescription,
      'meta_keyword': metaKeyword,
      'has_options': hasOptions,
      'shipping_country': shippingCountry,

      'options': options?.map((e) => e.toJson()).toList(),
      'attributes': attributes?.map((e) => e.toJson()).toList(),

      'manufacturer_id': manufacturerId,
      'brand_name': brandName,
      'brand_image': brandImage,
      'size_guide': sizeGuide,
      'share_text': shareText,
      'share_url': shareUrl,
      'tax_class_id': taxClassId,
      'weight': weight,
      'length': length,
      'width': width,
      'height': height,
      'reviews': reviews,
      'date_added': dateAdded,
      'date_modified': dateModified,
      'category_name': categoryName,
      'master_category_id': masterCategoryId,
      'flashsale_special': flashsaleSpecial,
      'tamara_link': tamaraLink,
      'tamara_text': tamaraText,
      'tamara_sub_text': tamaraSubText,
      'is_show_tabby_label': isShowTabbyLabel,
      'pre_order_text': preOrderText,
      'pre_order_item': preOrderItem,
      'pre_order_note': preOrderNote,
      'is_out_of_stock': isOutOfStock,
      'out_of_stock_text': outOfStockText,
    };
  }
}

class ProductImageModel {
  final String url;

  ProductImageModel({required this.url});

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(url: json['url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'url': url};
  }
}

class Options {
  String? name;
  String? productOptionId;
  String? required;
  String? sizeGuide;
  List<Variants>? variants;

  Options({
    this.name,
    this.productOptionId,
    this.required,
    this.sizeGuide,
    this.variants,
  });

  Options.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    productOptionId = json['product_option_id'];
    required = json['required'];
    sizeGuide = json['size_guide'];
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['product_option_id'] = productOptionId;
    data['required'] = required;
    data['size_guide'] = sizeGuide;
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Variants {
  String? label;
  String? priceVariance;
  String? optionId;
  String? description;
  String? availableQuantity;

  Variants({
    this.label,
    this.priceVariance,
    this.optionId,
    this.description,
    this.availableQuantity,
  });

  Variants.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    priceVariance = json['price_variance'];
    optionId = json['option_id'];
    description = json['description'];
    availableQuantity = json['available_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['price_variance'] = priceVariance;
    data['option_id'] = optionId;
    data['description'] = description;
    data['available_quantity'] = availableQuantity;
    return data;
  }
}

class Attributes {
  String? attributeGroupId;
  String? name;
  List<Attribute>? attribute;

  Attributes({this.attributeGroupId, this.name, this.attribute});

  Attributes.fromJson(Map<String, dynamic> json) {
    attributeGroupId = json['attribute_group_id'];
    name = json['name'];
    if (json['attribute'] != null) {
      attribute = <Attribute>[];
      json['attribute'].forEach((v) {
        attribute!.add(Attribute.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_group_id'] = attributeGroupId;
    data['name'] = name;
    if (attribute != null) {
      data['attribute'] = attribute!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attribute {
  String? attributeId;
  String? name;
  String? text;

  Attribute({this.attributeId, this.name, this.text});

  Attribute.fromJson(Map<String, dynamic> json) {
    attributeId = json['attribute_id'];
    name = json['name'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attribute_id'] = attributeId;
    data['name'] = name;
    data['text'] = text;
    return data;
  }
}
