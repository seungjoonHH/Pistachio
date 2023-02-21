import 'package:pistachio/model/enum/part.dart';

class Edge {
  late Part part1;
  late Part part2;

  Edge(this.part1, this.part2);
  Edge.index(int index1, int index2) {
    part1 = Part.values[index1];
    part2 = Part.values[index2];
  }
}