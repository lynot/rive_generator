// ignore_for_file: parameter_assignments

import 'dart:math';

import 'package:rive_dart_importer/src/generated/animation/elastic_interpolator_base.dart';
import 'package:rive_dart_importer/src/rive_core/animation/interpolator.dart';
import 'package:rive_dart_importer/src/rive_core/enum_helper.dart';

export 'package:rive_dart_importer/src/generated/animation/elastic_interpolator_base.dart';

enum Easing {
  easeIn,
  easeOut,
  easeInOut,
}

class ElasticEase {
  final double amplitude;
  final double s;
  final double period;

  ElasticEase(this.amplitude, this.period)
      : s = amplitude < 1.0
            ? period / 4
            : period / (2 * pi) * asin(1.0 / amplitude);

  double computeActualAmplitude(double time) {
    if (amplitude < 1.0) {
      /// We use this when the amplitude is less than 1.0 (amplitude is
      /// described as factor of change in value). We also precompute s which is
      /// the effective starting period we use to align the decaying sin with
      /// our keyframe.
      double t = s.abs();
      if (time.abs() < t) {
        double l = time.abs() / t;
        return (amplitude * l) + (1.0 - l);
      }
    }

    return amplitude;
  }

  double easeOut(double value) {
    var time = value;

    var actualAmplitude = computeActualAmplitude(time);

    return (actualAmplitude *
            pow(2, 10 * -time) *
            sin((time - s) * (2 * pi) / period)) +
        1;
  }

  double easeIn(double value) {
    var time = value - 1;

    var actualAmplitude = computeActualAmplitude(time);

    return -(actualAmplitude *
        pow(2, 10 * time) *
        sin((-time - s) * (2 * pi) / period));
  }

  double easeInOut(double value) {
    var time = value * 2 - 1;
    var actualAmplitude = computeActualAmplitude(time);
    if (time < 0) {
      return -0.5 *
          actualAmplitude *
          pow(2, 10 * time) *
          sin((-time - s) * (2 * pi) / period);
    } else {
      return 0.5 *
              (actualAmplitude *
                  pow(2, 10 * -time) *
                  sin((time - s) * (2 * pi) / period)) +
          1;
    }
  }
}

class ElasticInterpolator extends ElasticInterpolatorBase {
  ElasticEase _elastic = ElasticEase(1.0, 0.5);

  @override
  bool equalParameters(Interpolator other) {
    if (other is ElasticInterpolator) {
      return easingValue == other.easingValue &&
          amplitude == other.amplitude &&
          period == other.period;
    }
    return false;
  }

  @override
  void onAddedDirty() {}

  @override
  double transform(double value) {
    switch (easing) {
      case Easing.easeIn:
        return _elastic.easeIn(value);
      case Easing.easeOut:
        return _elastic.easeOut(value);
      case Easing.easeInOut:
        return _elastic.easeInOut(value);
    }
  }

  @override
  double transformValue(double from, double to, double value) {
    var f = transform(value);
    return from + (to - from) * f;
  }

  Easing get easing => enumAt(Easing.values, easingValue);
  set easing(Easing value) => easingValue = value.index;

  @override
  void updateInterpolator() {
    _elastic = ElasticEase(amplitude, period == 0 ? 0.5 : period);
    super.updateInterpolator();
  }

  @override
  void amplitudeChanged(double from, double to) => updateInterpolator();

  @override
  void easingValueChanged(int from, int to) => updateInterpolator();

  @override
  void periodChanged(double from, double to) => updateInterpolator();
}
