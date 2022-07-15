import 'package:json_annotation/json_annotation.dart';
import 'package:quotex/domain/models/signal/signal.dart';

part 'signals_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SignalsData {
  const SignalsData({
    required this.stockSignals,
    required this.currencySignals,
    required this.commoditySignals,
    required this.lastUpdate,
  });

  factory SignalsData.fromJson(Map<String, dynamic> json) => _$SignalsDataFromJson(json);
  Map<String, dynamic> toJson() => _$SignalsDataToJson(this);

  final List<Signal> stockSignals;
  final List<Signal> currencySignals;
  final List<Signal> commoditySignals;

  final DateTime lastUpdate;
}
