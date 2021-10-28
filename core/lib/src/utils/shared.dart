import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class Shared {
  static Future<HttpClient> customHttpClient({
    bool isTestMode = false,
  }) async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);
    try {
      List<int> bytes = [];
      if (isTestMode) {
        bytes = utf8.encode(_certificatedString);
      } else {
        bytes = (await rootBundle.load('assets/api_ssl_pinning.pem')).buffer.asUint8List();
      }

      context.setTrustedCertificatesBytes(bytes);
      log('createHttpClient() - cert added!');
    } on TlsException catch (e) {
      if (e.osError?.message != null && e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('createHttpClient() - cert already trusted! Skipping.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('unexpected error $e');
      rethrow;
    }
    HttpClient httpClient = HttpClient(context: context);
    httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false;

    return httpClient;
  }

  static Future<http.Client> createLEClient({bool isTestMode = false}) async {
    IOClient client = IOClient(await Shared.customHttpClient(isTestMode: isTestMode));
    return client;
  }
}

const _certificatedString = """-----BEGIN CERTIFICATE-----
MIIFOTCCBCGgAwIBAgISBIXBeQA3mOptaXwQntEkUu9fMA0GCSqGSIb3DQEBCwUA
MDIxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MQswCQYDVQQD
EwJSMzAeFw0yMTA5MTYyMDE4MDFaFw0yMTEyMTUyMDE4MDBaMCQxIjAgBgNVBAMT
GWRldmVsb3BlcnMudGhlbW92aWVkYi5vcmcwggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQCy3XH/Fgx6zlKEqc8MB5dbJT/Gb2D/U8YtnDwG7DEDxugsLjdB
Q5uhx+tK7HpBN6gTAMfj86gUL+G9XpYrSXI6rYD3mPS6CXjkSJSOrgcupPGezEu+
qQoQmu1uAfLbrpUEtsM+1GPpxxVRoXyEDtfyss+ygPUZrIj6Mxpj5dOg8KmKZplO
4sudCAj3oSVcY0yjsY9GL8T7ofXWIT3+cCO1UIjTW52/ZdmiyiC1CoxSK8Fh+dZi
uYixEt+SkBE9Dx56rOh4Ezz9hvPTz7m+XCXA4scIhTuXYNu+/DfvZ3/ILVnx2dPP
dP+R28+pquSsHX5xqGSE/YJfKwdxWCbo4JypAgMBAAGjggJVMIICUTAOBgNVHQ8B
Af8EBAMCBaAwHQYDVR0lBBYwFAYIKwYBBQUHAwEGCCsGAQUFBwMCMAwGA1UdEwEB
/wQCMAAwHQYDVR0OBBYEFLssoXpSFDMhuxgut3/DwSKAH01/MB8GA1UdIwQYMBaA
FBQusxe3WFbLrlAJQOYfr52LFMLGMFUGCCsGAQUFBwEBBEkwRzAhBggrBgEFBQcw
AYYVaHR0cDovL3IzLm8ubGVuY3Iub3JnMCIGCCsGAQUFBzAChhZodHRwOi8vcjMu
aS5sZW5jci5vcmcvMCQGA1UdEQQdMBuCGWRldmVsb3BlcnMudGhlbW92aWVkYi5v
cmcwTAYDVR0gBEUwQzAIBgZngQwBAgEwNwYLKwYBBAGC3xMBAQEwKDAmBggrBgEF
BQcCARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5vcmcwggEFBgorBgEEAdZ5AgQC
BIH2BIHzAPEAdgCUILwejtWNbIhzH4KLIiwN0dpNXmxPlD1h204vWE2iwgAAAXvw
eTeAAAAEAwBHMEUCICjoQsWzMq8S0AoiNjAnJH7MpuleuYE/JUgxH84Fp0aRAiEA
77czC1B6XZGMsVv/k3Ita5OR8VWphOFqgA2rtqNVPgcAdwD2XJQv0XcwIhRUGAgw
lFaO400TGTO/3wwvIAvMTvFk4wAAAXvweTlnAAAEAwBIMEYCIQCpGwMFmu35tHm5
+yTeJbX8lRjM1jpHkq8MdtxWkl6VvQIhAPyJdpDzWzpaSvhj/NFKL1cgKtZJqdXB
nWScgaFS9yM2MA0GCSqGSIb3DQEBCwUAA4IBAQCspqN5TwAxSumtQZJtM9RKuvHq
8pMkdY90yr1K37qnwr8OD+i580cJmC/7KaTlitkB9KPNTz0iUxs+wbcjeyqTraoU
BYZmDuebCjaFfaIFlpAuMZnxEJcsVCyNgmaXmmtcuuvbRbtLktfq67afUYYz5/6D
R2yQH/cr7IW92ls+yHzvjJi3TMuAtYOs5FAQcdCT+rDPfZnuDtojp/39PMqDuX+3
4nE4zehuNIPIbjaBNIA9Acdtsei4Zzw7s2U3Yf6/140D+B/dbQOfT1LLPTmZWWAq
UhabLTGs0qN2E8w59oXxhcztsw64Auek6debA6NeHMOOCWS7DkwwjqadcGYH
-----END CERTIFICATE-----""";
