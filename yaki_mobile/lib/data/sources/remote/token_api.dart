import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'token_api.g.dart';

@RestApi()
abstract class TokenApi {
  factory TokenApi(Dio dio, {required String baseUrl}) = _TokenApi;

  @GET('/verify-token')
  Future<HttpResponse> verifyTokenValidity();
}
