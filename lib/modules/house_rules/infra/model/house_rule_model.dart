import 'package:search_and_stay_challenge/modules/house_rules/domain/entities/house_rule_entity.dart';

class HouseRuleModel extends HouseRuleEntity {
  HouseRuleModel(
      {super.id, required super.name, required super.active, super.order});

  factory HouseRuleModel.fromJson(Map<String, dynamic> json) {
    return HouseRuleModel(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'active': active,
    };
  }
}
