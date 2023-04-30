import 'package:dartz/dartz.dart';

import '../entities/house_rule_entity.dart';
import '../repositories/house_rules_repository.dart';

abstract class UpdateHouseRuleUseCase {
  Future<Either<Exception, HouseRuleEntity>> call(HouseRuleEntity houseRule);
}

class UpdateHouseRuleUseCaseImpl implements UpdateHouseRuleUseCase {
  final IHouseRuleRepository repository;

  UpdateHouseRuleUseCaseImpl(this.repository);

  @override
  Future<Either<Exception, HouseRuleEntity>> call(
      HouseRuleEntity houseRule) async {
    return await repository.updateHouseRule(houseRule);
  }
}
