import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../infra/datasource/house_rule_external_datasource.dart';
import '../../infra/model/house_rule_model.dart';

class HouseRuleHttpDatasourceImpl implements IHouseRuleExternalDatasource {
  @override
  Future<HouseRuleModel> createHouseRule(HouseRuleModel houseRule) async {
    final response = await http.post(
      Uri.parse('https://sys-dev.searchandstay.com/api/admin/house_rules'),
      body: jsonEncode({
        'house_rules': houseRule.toJson(),
      }),
      headers: {
        'Authorization':
            'Bearer 40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8'
      },
    );
    if (response.statusCode == 200) {
      return HouseRuleModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Error creating house rule');
    }
  }

  @override
  Future<String> deleteHouseRule(int id) async {
    final response = await http.delete(
      Uri.parse('https://sys-dev.searchandstay.com/api/admin/house_rules/$id'),
      headers: {
        'Authorization':
            'Bearer 40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8'
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['message'];
    } else {
      throw Exception('Error deleting house rule');
    }
  }

  @override
  Future<HouseRuleModel> getHouseRule(int id) async {
    final response = await http.get(
      Uri.parse('https://sys-dev.searchandstay.com/api/admin/house_rules/$id'),
      headers: {
        'Authorization':
            'Bearer 40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8'
      },
    );
    if (response.statusCode == 200) {
      return HouseRuleModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Error getting house rule');
    }
  }

  @override
  Future<List<HouseRuleModel>> getHouseRules(int page) async {
    final response = await http.get(
      Uri.parse(
          'https://sys-dev.searchandstay.com/api/admin/house_rules?page=$page'),
      headers: {
        'Authorization':
            'Bearer 40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8'
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['entities']
          .map<HouseRuleModel>((json) => HouseRuleModel.fromJson(json))
          .toList();
    } else {
      throw Exception('Error getting house rules');
    }
  }

  @override
  Future<HouseRuleModel> updateHouseRule(HouseRuleModel houseRule) async {
    final response = await http.put(
      Uri.parse(
          'https://sys-dev.searchandstay.com/api/admin/house_rules/${houseRule.id}'),
      headers: {
        'Authorization':
            'Bearer 40fe071962846075452a4f6123ae71697463cad20f51e237e2035b41af0513d8'
      },
      body: jsonEncode({
        'house_rules': houseRule.toJson(),
      }),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data']['entities']
          .map<HouseRuleModel>((json) => HouseRuleModel.fromJson(json));
    } else {
      throw Exception('Error updating house rule');
    }
  }
}
