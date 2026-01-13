import 'package:app_template/data/api_client/api_client_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../mocks/mocks.mocks.dart';

void main() {
  late MockDio mockDio;
  late ApiClientImpl apiClient;

  setUp(() {
    mockDio = MockDio();
    apiClient = ApiClientImpl(mockDio);
  });

  group('ApiClientImpl', () {
    const testPath = '/test';
    final testResponse = Response(
      requestOptions: RequestOptions(path: testPath),
      statusCode: 200,
      data: {'message': 'success'},
    );

    test('GET request', () async {
      when(
        mockDio.get(
          any,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer((_) async => testResponse);

      final response = await apiClient.get(testPath);

      expect(response.statusCode, 200);
      expect(response.data, {'message': 'success'});

      verify(
        mockDio.get(
          testPath,
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('POST request', () async {
      when(
        mockDio.post(
          any,
          data: anyNamed('data'),
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer((_) async => testResponse);

      final response = await apiClient.post(testPath, data: {'key': 'value'});

      expect(response.statusCode, 200);
      expect(response.data, {'message': 'success'});

      verify(
        mockDio.post(
          testPath,
          data: {'key': 'value'},
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('PUT request', () async {
      when(
        mockDio.put(
          any,
          data: anyNamed('data'),
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer((_) async => testResponse);

      final response = await apiClient.put(testPath, data: {'key': 'value'});

      expect(response.statusCode, 200);
      expect(response.data, {'message': 'success'});

      verify(
        mockDio.put(
          testPath,
          data: {'key': 'value'},
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('PATCH request', () async {
      when(
        mockDio.patch(
          any,
          data: anyNamed('data'),
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer((_) async => testResponse);

      final response = await apiClient.patch(testPath, data: {'key': 'value'});

      expect(response.statusCode, 200);
      expect(response.data, {'message': 'success'});

      verify(
        mockDio.patch(
          testPath,
          data: {'key': 'value'},
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).called(1);
    });

    test('DELETE request', () async {
      when(
        mockDio.delete(
          any,
          data: anyNamed('data'),
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).thenAnswer((_) async => testResponse);

      final response = await apiClient.delete(testPath);

      expect(response.statusCode, 200);
      expect(response.data, {'message': 'success'});

      verify(
        mockDio.delete(
          testPath,
          data: anyNamed('data'),
          queryParameters: anyNamed('queryParameters'),
          options: anyNamed('options'),
        ),
      ).called(1);
    });
  });
}
