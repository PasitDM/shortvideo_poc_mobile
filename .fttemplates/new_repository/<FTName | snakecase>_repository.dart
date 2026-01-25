// TODO: Import your Datasource
// import 'package:lotplus/app/data/datasources/api/.../<FTName | snakecase>_datasource_api.dart';

class <FTName | pascalcase>Repository {
  final <FTName | pascalcase>DatasourceApi _<FTName | camelcase>DatasourceApi;

  <FTName | pascalcase>Repository({<FTName | pascalcase>DatasourceApi? <FTName | camelcase>RemoteImpl})
      : _<FTName | camelcase>DatasourceApi = <FTName | camelcase>RemoteImpl ?? <FTName | pascalcase>DatasourceApi();

  // Future<dynamic> getData() {
  //   return _<FTName | camelcase>DatasourceApi.getData();
  // }
}
