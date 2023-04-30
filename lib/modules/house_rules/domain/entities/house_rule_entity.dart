class HouseRuleEntity {
  int? id;
  String name;
  int active;
  int? order;

  HouseRuleEntity({
    this.id,
    required this.name,
    required this.active,
    this.order,
  });
}
