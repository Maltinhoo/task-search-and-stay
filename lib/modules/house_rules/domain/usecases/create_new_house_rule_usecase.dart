import 'package:dartz/dartz.dart';

import '../entities/house_rule_entity.dart';
import '../repositories/house_rules_repository.dart';

abstract class CreateNewHouseRuleUseCase {
  Future<Either<Exception, HouseRuleEntity>> call(HouseRuleEntity houseRule);
}

class CreateNewHouseRuleUseCaseImpl implements CreateNewHouseRuleUseCase {
  final IHouseRuleRepository repository;

  CreateNewHouseRuleUseCaseImpl(this.repository);

  @override
  Future<Either<Exception, HouseRuleEntity>> call(
      HouseRuleEntity houseRule) async {
    return await repository.createNewHouseRule(houseRule);
  }
}
