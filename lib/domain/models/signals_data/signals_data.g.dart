// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signals_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignalsData _$SignalsDataFromJson(Map<String, dynamic> json) => SignalsData(
      stockSignals: (json['stockSignals'] as List<dynamic>)
          .map((e) => Signal.fromJson(e as Map<String, dynamic>))
          .toList(),
      currencySignals: (json['currencySignals'] as List<dynamic>)
          .map((e) => Signal.fromJson(e as Map<String, dynamic>))
          .toList(),
      commoditySignals: (json['commoditySignals'] as List<dynamic>)
          .map((e) => Signal.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastUpdate: DateTime.parse(json['lastUpdate'] as String),
    );

Map<String, dynamic> _$SignalsDataToJson(SignalsData instance) =>
    <String, dynamic>{
      'stockSignals': instance.stockSignals.map((e) => e.toJson()).toList(),
      'currencySignals':
          instance.currencySignals.map((e) => e.toJson()).toList(),
      'commoditySignals':
          instance.commoditySignals.map((e) => e.toJson()).toList(),
      'lastUpdate': instance.lastUpdate.toIso8601String(),
    };
