import 'dart:convert';
import 'package:http/http.dart' as http;
Future<Map<String, dynamic>> getB2CTransaction(String accessToken, String transId) async {
  String url = "https://api.safaricom.co.ke/mpesa/b2c/v1/paymentresulthistory";
  String initiatorName = "YOUR_INITIATOR_NAME";
  String securityCredential = "YOUR_SECURITY_CREDENTIAL";

  Map<String, String> headers = {
    'Authorization': 'Bearer $accessToken',
    'Content-Type': 'application/json'
  };

  Map<String, dynamic> body = {
    'InitiatorName': initiatorName,
    'SecurityCredential': securityCredential,
    'ResultURL': '',
    'QueueTimeOutURL': '',
    'CommandID': 'TransactionStatusQuery',
    'PartyA': '',
    'IdentifierType': '',
    'Remarks': '',
    'Amount': '',
    'PartyB':'',
    // Set ResultType to 0 for single transaction
    'ResultType':'0',
    'Occasion':'',
    // Set TransID to desired transaction ID
    'TransID': transId,
  };

  http.Response response =
  await http.post(url as Uri, headers: headers, body: json.encode(body));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  } else {
    throw Exception('Failed to get transaction history');
  }
}