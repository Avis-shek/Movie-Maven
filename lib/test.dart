
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert' as convert;
// import 'package:http_auth/http_auth.dart';

// class PaypalServices {
//   String domain = "https://api.sandbox.paypal.com"; // for sandbox mode
//   String clientId = 'Ab4vS4vmfQFgUuQMH49F9Uy3L1FdNHtfGrASCyjNijm_EkHWCFM96ex0la-YFbwavw41R3rTKU3k_Bbm';
//   String secret = 'EDjvPfYgTYqdYWR2BfOiBW4dz_jeeuadqH7Z98pZMDvY33PcViiooqYFWVPFSGbfKBfNOb3LnroSI1hv';

//   // for getting the access token from Paypal
//   Future<String?> getAccessToken() async {
//     try {
//       var client = BasicAuthClient(clientId, secret);
//       var response = await client.post('$domain/v1/oauth2/token?grant_type=client_credentials' as Uri);
//       if (response.statusCode == 200) {
//         final body = convert.jsonDecode(response.body);
//         return body["access_token"];
//       }
//       return null;
//     } catch (e) {
//       rethrow;
//     }
//   }
//   }