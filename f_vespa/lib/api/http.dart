import 'dart:convert';

import 'package:http/http.dart' as http;

const _kApiKey = 'MY_API_KEY';
const _kBaseUrl = 'api.hgbrasil.com';
const _kPricePath = 'finance/stock_price';

Future<Map<String, dynamic>> getStockPriceJson(String symbol) async {
  final headers = {'key': _kApiKey, 'symbol': symbol};
  final uri = Uri.https(_kBaseUrl, _kPricePath, headers);
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    return jsonDecode(response.body)['results'][symbol];
  } else {
    return {};
  }
}
