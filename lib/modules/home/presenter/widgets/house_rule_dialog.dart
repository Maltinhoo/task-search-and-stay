import 'package:flutter/material.dart';
import 'package:search_and_stay_challenge/modules/house_rules/domain/entities/house_rule_entity.dart';

class HouseRuleDialog extends StatelessWidget {
  final HouseRuleEntity rule;
  const HouseRuleDialog({
    super.key,
    required this.rule,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'House Rule',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text('Name: ${rule.name}'),
          Text(rule.active == 1 ? 'Active' : 'Inactive',
              style: TextStyle(
                  color: rule.active == 1 ? Colors.green : Colors.red)),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context), child: const Text('Ok'))
      ],
    );
  }
}
