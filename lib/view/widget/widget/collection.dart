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
    this.highlight = false,
    this.onPressed,
  }) : super(key: key);

  final Collection? collection;
  final bool detail;
  final bool highlight;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    PolygonBorder side = PolygonBorder(
      sides: 6,
      side: BorderSide(
        width: 1.5,
        color: highlight
            ? PTheme.brickRed
            : PTheme.black,
      ),
    );

    return Column(
      children: [
        Material(
          color: PTheme.grey,
          shape: side,
          child: InkWell(
            onTap: onPressed,
            customBorder: side,
            child: Column(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: ShapeDecoration(
                    color: highlight ? null : PTheme.white.withOpacity(.7),
                    shape: side,
                  ),
                ),
              ],
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
