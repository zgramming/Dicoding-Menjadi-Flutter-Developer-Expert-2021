import 'package:core/core.dart';
import 'package:core/src/utils/shared.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // TestWidgetsFlutterBinding.ensureInitialized();

  group('SSL Pinning Http ', () {
    test(
      'Should get response 200 when success connect',
      () async {
        // ByteData bytes = await rootBundle.load('assets/api_ssl_pinning.pem');
        // log('bytse ${bytes}');
        final _client = await Shared.createLEClient(isTestMode: true);
        final response = await _client.get(Uri.parse(URL_SSL_PINNING));
        expect(response.statusCode, 200);
        _client.close();
      },
    );
  });
}
