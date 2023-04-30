import 'package:dartz/dartz.dart';

import '../entities/house_rule_entity.dart';
import '../repositories/house_rules_repository.dart';

abstract class GetHouseRuleUseCase {
  Future<Either<Exception, HouseRuleEntity>> call(int id);
}

class GetHouseRuleUseCaseImpl implements GetHouseRuleUseCase {
  final IHouseRuleRepository repository;

  GetHouseRuleUseCaseImpl(this.repository);

  @override
  Future<Either<Exception, HouseRuleEntity>> call(int id) async {
    return await repository.getHouseRule(id);
  }
}
