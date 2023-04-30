import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../../api/api_helper.dart';
import '../../infra/datasource/house_rule_external_datasource.dart';
import '../../infra/model/house_rule_model.dart';

class HouseRuleHttpDatasourceImpl implements IHouseRuleExternalDatasource {
  @override
  Future<HouseRuleModel> createHouseRule(HouseRuleModel houseRule) async {
    final response = await http.post(
      Uri.parse(endPoint),
      body: jsonEncode({
        'house_rules': houseRule.toJson(),
      }),
      headers: {'Authorization': authorization},
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
      Uri.parse('$endPoint/$id'),
      headers: {'Authorization': authorization},
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
      Uri.parse('$endPoint/$id'),
      headers: {'Authorization': authorization},
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
      Uri.parse('$endPoint?page=$page'),
      headers: {'Authorization': authorization},
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
      Uri.parse('$endPoint/${houseRule.id}'),
      headers: {'Authorization': authorization},
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
