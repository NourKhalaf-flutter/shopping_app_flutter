import 'package:first/core/network/api_client.dart';
import 'package:first/core/network/api_endpoints.dart';
import 'package:first/core/network/response_wrapper.dart';

abstract class ProductsRemoteDataSource {
  Future<ResponseWrapper<dynamic>> products({  required int page,});
    Future<ResponseWrapper<dynamic>> relatedProducts({  required int productId,});
    Future<ResponseWrapper<dynamic>> productDetails({  required int productId,});

}

class ProductsRemoteDataSourceImp implements ProductsRemoteDataSource {
  final ApiClient apiClient;

  ProductsRemoteDataSourceImp({required this.apiClient});

  @override
  Future<ResponseWrapper<dynamic>> products({required int page}) async {
    return await apiClient.get(ApiEndpoints.products,queryParameters: {
        'page': page,
      },);
  }
   @override
  Future<ResponseWrapper<dynamic>> relatedProducts({required int productId}) async {
    return await apiClient.get(ApiEndpoints.relatedProducts,queryParameters: {
        'prod_id': productId,
      },);
  }

     @override
  Future<ResponseWrapper<dynamic>> productDetails({required int productId}) async {
    return await apiClient.get(ApiEndpoints.productDetails,queryParameters: {
        'product_id': productId,
      },);
  }
}
