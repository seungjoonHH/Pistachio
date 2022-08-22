import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:pistachio/global/theme.dart';
import 'package:pistachio/model/class/collection.dart';
import 'package:pistachio/view/widget/widget/text.dart';

class CollectionWidget extends StatelessWidget {
  const CollectionWidget({
    Key? key,
    this.collection,
    this.detail = false,
  }) : super(key: key);

  final Collection? collection;
  final bool detail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: const ShapeDecoration(
            color: PTheme.grey,
            shape: PolygonBorder(
              sides: 6,
              side: BorderSide(width: 1.5),
            ),
          ),
        ),
        if (detail)
        Column(
          children: [
            const SizedBox(height: 10.0),
            PText(
              collection?.title ?? '',
              maxLines: 2,
              align: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: PTheme.black, width: 1.5),
              ),
              child: PText('15', border: true),
            ),
          ],
        ),
      ],
    );
  }
}
