import 'package:dartz/dartz.dart';
import 'package:search_and_stay_challenge/modules/house_rules/domain/entities/house_rule_entity.dart';

import '../../domain/repositories/house_rules_repository.dart';
import '../datasource/house_rule_external_datasource.dart';
import '../model/house_rule_model.dart';

class HouseRuleRepository implements IHouseRuleRepository {
  final IHouseRuleExternalDatasource externalDatasource;

  HouseRuleRepository(this.externalDatasource);
  @override
  Future<Either<Exception, HouseRuleEntity>> createNewHouseRule(
      HouseRuleEntity houseRule) async {
    try {
      final result =
          await externalDatasource.createHouseRule(houseRule as HouseRuleModel);
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, String>> deleteHouseRule(int id) async {
    try {
      final result = await externalDatasource.deleteHouseRule(id);
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, List<HouseRuleEntity>>> getAllHouseRules(
      int page) async {
    try {
      final result = await externalDatasource.getHouseRules(page);
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, HouseRuleEntity>> getHouseRule(int id) async {
    try {
      final result = await externalDatasource.getHouseRule(id);
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, HouseRuleEntity>> updateHouseRule(
      HouseRuleEntity houseRule) async {
    try {
      final result =
          await externalDatasource.updateHouseRule(houseRule as HouseRuleModel);
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  }
}
