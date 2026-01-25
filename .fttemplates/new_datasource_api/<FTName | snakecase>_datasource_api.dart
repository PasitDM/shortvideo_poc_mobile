import 'package:lotplus/app/data/services/api_handler/api_service.dart';
import 'package:dio/dio.dart';

class <FTName | pascalcase>DatasourceApi {
  Future<dynamic> getData() async {
    try {
      final response = await ApiService().request(
        urlType: UrlType.searchApiGateway,
        path: "/api/v2/path",
        method: Method.GET,
      );
      return response.data;
    } on DioException catch (dioErr) {
      final responseData = dioErr.response?.data;
      return responseData ?? {};
    } catch (e) {
      throw Exception("API Error: $e");
    }
  }
}
