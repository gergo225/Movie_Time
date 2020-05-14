import 'dart:ui';

Color darkenColorBy(Color color, int amount) {
  assert (amount >= 0 && amount <= 255);
  int newRed = _darkenChannel(color.red, amount);
  int newGreen = _darkenChannel(color.green, amount);
  int newBlue = _darkenChannel(color.blue, amount);
  return Color.fromRGBO(newRed, newGreen, newBlue, 1);
}

int _darkenChannel(int channel, int amount) => (channel - amount).clamp(0, 255);