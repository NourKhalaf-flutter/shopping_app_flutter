class RelatedProductModel {
  String? productId;
  String? sku;
  String? name;
  String? description;
  String? discountPercentage;
  String? quantity;
  String? image;
  String? special;
  String? price;
  bool? freeShipping;
  String? priceWithoutVat;
  String? currency;
  int? isBuyThisLook;
  int? isRelatedProducts;
  bool? isReturnable;
  bool? isNew;
  bool? isExclusive;
  List<String>? label;
  bool? showLabel;
  String? insiderCategoryId;
  String? insiderCategoryLabel;
  String? baseCurrency;
  String? baseCurrencyPrice;
  String? baseCurrencySpecialPrice;

  RelatedProductModel(
      {this.productId,
      this.sku,
      this.name,
      this.description,
      this.discountPercentage,
      this.quantity,
      this.image,
      this.special,
      this.price,
      this.freeShipping,
      this.priceWithoutVat,
      this.currency,
      this.isBuyThisLook,
      this.isRelatedProducts,
      this.isReturnable,
      this.isNew,
      this.isExclusive,
      this.label,
      this.showLabel,
      this.insiderCategoryId,
      this.insiderCategoryLabel,
      this.baseCurrency,
      this.baseCurrencyPrice,
      this.baseCurrencySpecialPrice});

  RelatedProductModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    sku = json['sku'];
    name = json['name'];
    description = json['description'];
    discountPercentage = json['discount_percentage'];
    quantity = json['quantity'];
    image = json['image'];
    special = json['special'];
    price = json['price'];
    freeShipping = json['free_shipping'];
    priceWithoutVat = json['price_without_vat'];
    currency = json['currency'];
    isBuyThisLook = json['is_buy_this_look'];
    isRelatedProducts = json['is_related_products'];
    isReturnable = json['is_returnable'];
    isNew = json['is_new'];
    isExclusive = json['is_exclusive'];
  label = json['label'].cast<String>();
    showLabel = json['show_label'];
    insiderCategoryId = json['insider_category_id'];
    insiderCategoryLabel = json['insider_category_label'];
    baseCurrency = json['base_currency'];
    baseCurrencyPrice = json['base_currency_price'];
    baseCurrencySpecialPrice = json['base_currency_special_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['sku'] = sku;
    data['name'] = name;
    data['description'] = description;
    data['discount_percentage'] = discountPercentage;
    data['quantity'] = quantity;
    data['image'] = image;
    data['special'] = special;
    data['price'] = price;
    data['free_shipping'] = freeShipping;
    data['price_without_vat'] = priceWithoutVat;
    data['currency'] = currency;
    data['is_buy_this_look'] = isBuyThisLook;
    data['is_related_products'] = isRelatedProducts;
    data['is_returnable'] = isReturnable;
    data['is_new'] = isNew;
    data['is_exclusive'] = isExclusive;
      data['label'] = label;
    data['show_label'] = showLabel;
    data['insider_category_id'] = insiderCategoryId;
    data['insider_category_label'] = insiderCategoryLabel;
    data['base_currency'] = baseCurrency;
    data['base_currency_price'] = baseCurrencyPrice;
    data['base_currency_special_price'] = baseCurrencySpecialPrice;
    return data;
  }
}
