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
    this.selected = false,
    this.onPressed,
    this.size = 100.0,
  }) : super(key: key);

  final Collection? collection;
  final bool detail;
  final bool selected;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    PolygonBorder side = PolygonBorder(
      sides: 6,
      side: BorderSide(
        width: 1.5,
        color: onPressed != null && selected
            ? PTheme.brickRed : PTheme.black,
      ),
    );

    return Stack(
      children: [
        if (collection != null)
          Image.asset(collection!.imageUrl!,
            width: size,
            height: size,
          ),
        Column(
          children: [
            Material(
              color: collection == null
                  ? PTheme.grey : Colors.transparent,
              shape: side,
              child: InkWell(
                onTap: onPressed,
                customBorder: side,
                splashColor: PTheme.black.withOpacity(.1),
                child: Container(
                  width: size,
                  height: size,
                  decoration: ShapeDecoration(
                    color: onPressed != null && selected ? null
                        : PTheme.white.withOpacity(.7),
                    shape: side,
                  ),
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
        ),
      ],
    );
  }
}
