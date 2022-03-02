import 'dart:math' as math;

class RandomNumber {
  int nextInter(int min, int max) {
    int randomNumber = min + math.Random().nextInt(max - min);

    return randomNumber;
  }
}
