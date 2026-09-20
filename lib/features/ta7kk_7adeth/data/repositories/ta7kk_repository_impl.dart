import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:muslim_werd_app/features/ta7kk_7adeth/data/repositories/dorar_html_parser.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/models/hadith_ta7kk_result.dart';
import 'package:muslim_werd_app/features/ta7kk_7adeth/domain/repositories/ta7kk_repository.dart';

/// تنفيذ فعلي يستدعي dorar.net API ويعتمد على [DorarHtmlParser] للتحويل.
class Ta7kkRepositoryImpl implements Ta7kkRepository {
  Ta7kkRepositoryImpl({http.Client? client})
      : _client = client ?? http.Client();

  static const _baseUrl = 'https://dorar.net/dorar_api.json';

  final http.Client _client;
  final _parser = DorarHtmlParser();

  @override
  Future<List<HadithTa7kkResult>> search(String keywords) async {
    final uri = Uri.parse(
      '$_baseUrl?skey=${Uri.encodeQueryComponent(keywords)}',
    );

    final response = await _client
        .get(uri, headers: const {'Accept': 'application/json'})
        .timeout(const Duration(seconds: 20));

    if (response.statusCode != 200) {
      throw HttpException(
        statusCode: response.statusCode,
        message: 'فشل الاتصال بالخادم (${response.statusCode})',
      );
    }

    final decoded = jsonDecode(response.body);
    final resultHtml =
        (decoded['ahadith'] as Map?)?['result'] as String? ?? '';
    return _parser.parse(resultHtml);
  }
}

class HttpException implements Exception {
  const HttpException({required this.statusCode, required this.message});

  final int statusCode;
  final String message;

  @override
  String toString() => message;
}