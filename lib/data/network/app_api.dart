import 'package:advanced_flutter_project/app/constant.dart';
import 'package:advanced_flutter_project/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(
    Dio dio, {
    String? baseUrl,
  }) = _AppServiceClient;

  @POST("/customer/login")
  Future<AuthenticationResponse> login(
      @Field("email") String email, @Field("password") String password);
}
