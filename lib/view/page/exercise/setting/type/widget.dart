import 'package:pistachio/global/theme.dart';
import 'package:pistachio/presenter/page/exercise/main.dart';
import 'package:pistachio/view/widget/widget/text.dart';
import 'package:flutter/material.dart';

class ExerciseTypeView extends StatelessWidget {
  const ExerciseTypeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: const [
          ExerciseTypeCard(
            icon: Icons.fitness_center,
            type: '무게 측정',
          ),
          SizedBox(height: 12.0),
          ExerciseTypeCard(
            icon: Icons.directions_run,
            type: '거리 측정',
          ),
          SizedBox(height: 12.0),
          ExerciseTypeCard(
            icon: Icons.stairs_outlined,
            type: '높이 측정',
          ),
        ],
      ),
    );
  }
}

class ExerciseTypeCard extends StatelessWidget {
  final IconData icon;
  final String type;

  const ExerciseTypeCard({
    Key? key,
    required this.icon,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xfffbf8f1),
      child: InkWell(
        onTap: ExerciseMain.toExerciseDetailSetting,
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 56.0),
              const SizedBox(width: 20.0),
              FWText(type, style: textTheme.titleLarge),
            ],
          ),
        ),
      ),
    );
  }
}
