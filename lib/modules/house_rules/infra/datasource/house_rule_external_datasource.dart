import '../model/house_rule_model.dart';

abstract class IHouseRuleExternalDatasource {
  Future<List<HouseRuleModel>> getHouseRules(int page);
  Future<HouseRuleModel> updateHouseRule(HouseRuleModel houseRule);
  Future<HouseRuleModel> createHouseRule(HouseRuleModel houseRule);
  Future<String> deleteHouseRule(int id);
  Future<HouseRuleModel> getHouseRule(int id);
}
