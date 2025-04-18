class FImpPolType {
  double magnitude;
  double phase;
  FImpPolType({
    required this.magnitude,
    required this.phase,
  });
}

double ad5940AdcCode2Volt(int code, double adcPga, double vRef1p82)
{
  double kFactor = 1.835/1.82;
  double tmp = (code - 32768) / adcPga;
  return tmp * vRef1p82 / 32768 * kFactor;
}
