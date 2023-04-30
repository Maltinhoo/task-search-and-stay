import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:search_and_stay_challenge/modules/house_rules/domain/entities/house_rule_entity.dart';

class HouseRuleCard extends StatelessWidget {
  final HouseRuleEntity rule;
  final Function(BuildContext context) delete;
  final Function(BuildContext context) edit;
  final Function() onLongPress;
  const HouseRuleCard({
    super.key,
    required this.rule,
    required this.delete,
    required this.edit,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: Slidable(
          key: const ValueKey(0),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: delete,
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
              SlidableAction(
                onPressed: edit,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit,
                label: 'Editar',
              ),
            ],
          ),
          child: ListTile(
            title: Text(rule.name),
            subtitle: Text(rule.id.toString()),
            trailing: Text(rule.active == 1 ? 'Ativo' : 'Inativo',
                style: TextStyle(
                  color: rule.active == 1 ? Colors.green : Colors.red,
                  fontSize: 18,
                )),
          )),
    );
  }
}
