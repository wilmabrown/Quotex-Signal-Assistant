import 'package:json_annotation/json_annotation.dart';
import 'package:quotex/domain/models/currency/currency.dart';

part 'signal.g.dart';

enum SignalPeriod { m_1, m_2, m_3, m_4, m_5, m_10, m_15, m_30, m_45, h_1, h_2, h_3, h_4 }
enum SignalType { up, down }

@JsonSerializable(explicitToJson: true)
class Signal {
  const Signal({
    required this.one,
    required this.two,
    required this.date,
    required this.period,
    required this.type,
  });

  factory Signal.fromJson(Map<String, dynamic> json) => _$SignalFromJson(json);
  Map<String, dynamic> toJson() => _$SignalToJson(this);

  final Currency one;
  final Currency two;

  final DateTime date;
  final SignalPeriod period;
  final SignalType type;
}

extension SignalPeriodExt on SignalPeriod {
  String get asString {
    switch (this) {
      case SignalPeriod.m_1:
        return '01:00';
      case SignalPeriod.m_2:
        return '02:00';
      case SignalPeriod.m_3:
        return '03:00';
      case SignalPeriod.m_4:
        return '04:00';
      case SignalPeriod.m_5:
        return '05:00';
      case SignalPeriod.m_10:
        return '10:00';
      case SignalPeriod.m_15:
        return '15:00';
      case SignalPeriod.m_30:
        return '30:00';
      case SignalPeriod.m_45:
        return '45:00';
      case SignalPeriod.h_1:
        return '01:00:00';
      case SignalPeriod.h_2:
        return '02:00:00';
      case SignalPeriod.h_3:
        return '03:00:00';
      case SignalPeriod.h_4:
        return '04:00:00';
    }
  }
}
