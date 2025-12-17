import 'dart:convert';
import 'package:http/http.dart' as http;
import 'agreement_models.dart';

class AgreementApi {
  final String baseUrl;
  final http.Client client;

  AgreementApi({required this.baseUrl, http.Client? client})
      : client = client ?? http.Client();

  /// Fetch a single agreement by ID
  Future<Agreement> fetchAgreement(String agreementId) async {
    final response = await client.get(Uri.parse('$baseUrl/agreements/$agreementId'));

    if (response.statusCode == 200) {
      return Agreement.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch agreement');
    }
  }

  /// Fetch all agreements for a tenant or landlord
  Future<List<Agreement>> fetchAgreements({String? tenantId, String? landlordId}) async {
    final queryParams = <String, String>{};
    if (tenantId != null) queryParams['tenantId'] = tenantId;
    if (landlordId != null) queryParams['landlordId'] = landlordId;

    final uri = Uri.parse('$baseUrl/agreements').replace(queryParameters: queryParams);
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Agreement.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch agreements');
    }
  }
}