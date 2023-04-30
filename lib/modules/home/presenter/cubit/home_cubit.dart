import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:search_and_stay_challenge/modules/house_rules/domain/usecases/create_new_house_rule_usecase.dart';
import 'package:search_and_stay_challenge/modules/house_rules/domain/usecases/delete_house_rule_usecase.dart';
import 'package:search_and_stay_challenge/modules/house_rules/domain/usecases/get_house_rule_usecase.dart';
import 'package:search_and_stay_challenge/modules/house_rules/domain/usecases/update_house_rule_usecase.dart';

import '../../../house_rules/domain/entities/house_rule_entity.dart';
import '../../../house_rules/domain/usecases/get_house_rules_list_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHouseRulesListUseCase getHouseRulesListUseCase;
  final CreateNewHouseRuleUseCase createNewHouseRuleUseCase;
  final DeleteHouseRuleUseCase deleteHouseRuleUseCase;
  final UpdateHouseRuleUseCase updateHouseRuleUseCase;
  final GetHouseRuleUseCase getHouseRuleUseCase;

  HomeCubit(
    this.getHouseRulesListUseCase,
    this.createNewHouseRuleUseCase,
    this.deleteHouseRuleUseCase,
    this.updateHouseRuleUseCase,
    this.getHouseRuleUseCase,
  ) : super(HomeInitial());

  List<HouseRuleEntity> all = [];
  List<HouseRuleEntity> perPage = [];

  Future<void> getHouseRules(int? page) async {
    if (state is HomeLoading) return;
    all.clear();
    if ((page ?? 1) > 1) {
      emit(HomeLoadingMore());
    } else {
      emit(HomeLoading());
    }
    if (page != null) {
      if (page == 1) {
        all = [];
      }
    }
    try {
      final result = await getHouseRulesListUseCase(page ?? 1);
      result.fold(
        (l) => emit(HomeError(l.toString())),
        (r) {
          if (page != null) {
            all.addAll(r);
            perPage = r;
          }
          emit(HomeLoaded(r));
        },
      );
    } catch (e) {
      HomeError(e.toString());
    }
  }

  Future<void> addNewHouseRule(HouseRuleEntity houseRuleEntity) async {
    try {
      final result = await createNewHouseRuleUseCase(houseRuleEntity);
      result.fold(
        (l) => emit(HomeError(l.toString())),
        (r) {
          all.add(r);

          emit(HomeCreateNewHouseRule("House Rule Created"));
        },
      );
    } catch (e) {
      HomeError(e.toString());
    }
  }

  Future<void> deleteHouseRule(int id) async {
    try {
      final result = await deleteHouseRuleUseCase(id);
      result.fold(
        (l) => emit(HomeError(l.toString())),
        (r) {
          all.removeWhere((element) => element.id == id);
          emit(HomeDeleteHouseRule("House Rule Deleted"));
        },
      );
    } catch (e) {
      HomeError(e.toString());
    }
  }

  Future<void> updateHouseRule(HouseRuleEntity houseRuleEntity) async {
    try {
      await updateHouseRuleUseCase(houseRuleEntity);
      emit(HomeUpdateHouseRule("House Rule Updated"));
    } catch (e) {
      HomeError(e.toString());
    }
  }

  Future<void> getHouseRule(int id) async {
    try {
      final result = await getHouseRuleUseCase(id);
      result.fold(
        (l) => emit(HomeError(l.toString())),
        (r) {
          emit(HomeGetHouseRule(r));
        },
      );
    } catch (e) {
      HomeError(e.toString());
    }
  }
}
