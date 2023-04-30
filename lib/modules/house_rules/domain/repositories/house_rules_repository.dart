import 'package:dartz/dartz.dart';

import '../entities/house_rule_entity.dart';

abstract class IHouseRuleRepository {
  Future<Either<Exception, List<HouseRuleEntity>>> getAllHouseRules(int page);
  Future<Either<Exception, HouseRuleEntity>> getHouseRule(int id);
  Future<Either<Exception, HouseRuleEntity>> createNewHouseRule(
      HouseRuleEntity houseRule);
  Future<Either<Exception, HouseRuleEntity>> updateHouseRule(
      HouseRuleEntity houseRule);
  Future<Either<Exception, String>> deleteHouseRule(int id);
}
