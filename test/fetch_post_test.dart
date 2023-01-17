import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:moaktest_api/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_post_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group(
    'fetch album',
    () {
      test(
        'return an album http call completed',
        () async {
          final client = MockClient();
          when(
            client.get(
              Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
            ),
          ).thenAnswer(
            (realInvocation) async => http.Response(
              '{"userId": 3,"id": 1,"title": "quidem molestiae enim"}',
              200,
            ),
          );
          expect(await fetchAlbum(client), isA<Album>());
        },
      );
    },
  );
  test(
    'throw an exception if the http call error',
    () {
      final client = MockClient();
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer(
              (realInvocation) async => http.Response('Not Found', 404));
      expect(fetchAlbum(client), throwsException);
    },
  );
}
