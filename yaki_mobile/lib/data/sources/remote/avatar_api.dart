import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'avatar_api.g.dart';

@RestApi()
abstract class AvatarApi {
  /// Establishes the connection to the database using the baseUrl address<br>
  /// set in the environment variables (see user_provider.dart)
  factory AvatarApi(Dio dio, {required String baseUrl}) = _AvatarApi;

  @GET('/users/{id}/personal-avatar')
  Future<HttpResponse> getAvatarById(
    @Path('id') int id,
  );

  @POST('/users/{id}/avatar-selection')
  Future<HttpResponse> postAvatarById(
    @Path('id') int id,
    @Body() FormData formData,
  );
}
