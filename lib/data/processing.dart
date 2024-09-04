

import 'dart:math';

class Processing{

  static double predictRisk({
    required double gestationWeeks,
    required double cervicalDilationCm,
    required double caputSuccedaneumMm,
    required double headPerineumDistanceMm,
    required String occiputPosition,
    required double maternalAgeYears,
    required double maternalBmi,
    required bool prolongedLabor,
  }) {
    // Convert occiput position to a binary value
    int occiputPosterior = (occiputPosition == 'LOP' || occiputPosition == 'ROP') ? 1 : 0;

    // Convert prolonged labor to a binary value
    int prolongedLaborBinary = prolongedLabor ? 1 : 0;

    // Convert caput succedaneum to a binary value
    int caputBinary = caputSuccedaneumMm >= 10 ? 1 : 0;

    // Convert head perineum distance to a binary value
    int headPerineumBinary = headPerineumDistanceMm > 40 ? 1 : 0;

    // Compute the log of the risk score
    double logRiskScore = 18.52
        + 1.58 * headPerineumBinary
        + 1.62 * caputBinary
        - 0.57 * occiputPosterior
        + 0.07 * maternalAgeYears
        - 0.05 * maternalBmi
        - 0.51 * gestationWeeks
        - 1.31 * prolongedLaborBinary
        + 0.27 * cervicalDilationCm;

    // Compute the probability of vaginal delivery using the logistic function
    double probabilityVaginalDelivery = 1 / (1 + exp(-logRiskScore));

    return probabilityVaginalDelivery;
  }

  static String getRiskLabel(double probability) {
    if (probability >= 0.90) {
      return 'Highly Likely';
    } else if (probability >= 0.75) {
      return 'Likely';
    } else if (probability >= 0.50) {
      return 'Neutral';
    } else if (probability >= 0.25) {
      return 'Unlikely';
    } else {
      return 'Highly Unlikely';
    }
  }


}
