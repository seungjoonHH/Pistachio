import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class PCircularIndicator extends StatelessWidget {
  const PCircularIndicator({
    Key? key,
    required this.percent,
    required this.color,
    this.radius = 60.0,
    this.lineWidth = 16.0,
    this.centerText = '',

  }) : super(key: key);

  final double percent;
  final Color color;
  final double radius;
  final double lineWidth;
  final String centerText;

  @override
  Widget build(BuildContext context) {
    final border = Border.all(
      color: PTheme.black,
      width: 1.5,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: border,
            shape: BoxShape.circle,
          ),
          child: CircularPercentIndicator(
            radius: radius,
            lineWidth: lineWidth,
            percent: percent,
            backgroundColor: PTheme.offWhite,
            progressColor: color,
            animation: true,
            animationDuration: 1000,
            curve: Curves.easeInOut,
            center: PText(centerText,
              color: PTheme.white,
              border: true,
              style: textTheme.labelLarge,
              maxLines: 2,
              align: TextAlign.center
            ),
          ),
        ),
        Container(
          width: (radius - lineWidth) * 2,
          height: (radius - lineWidth) * 2,
          decoration: BoxDecoration(
            border: border,
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }
}
