import 'dart:math';

import 'package:mobx/mobx.dart';
import 'package:quotex/domain/mocks/mock_commodities.dart';
import 'package:quotex/domain/mocks/mock_currencies.dart';
import 'package:quotex/domain/mocks/mock_stocks.dart';
import 'package:quotex/domain/models/currency/currency.dart';
import 'package:quotex/domain/models/signal/signal.dart';
import 'package:quotex/domain/models/signals_data/signals_data.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/services/settings.dart';

part 'generate_data_state.g.dart';

class GenerateDataState = _GenerateDataStateBase with _$GenerateDataState;

abstract class _GenerateDataStateBase with Store {
  /// Информация будет добавляться в текущую каждые [_updatePeriod].
  static const Duration _updatePeriod = Duration(minutes: 4);

  static const int _fullUpdateCycles = 8;

  @observable
  DateTime lastUpdate = DateTime.now();

  @observable
  ObservableList<Signal> stocksSignals = ObservableList();

  @observable
  ObservableList<Signal> currencySignals = ObservableList();

  @observable
  ObservableList<Signal> commoditySignals = ObservableList();

  Future<void> _generateStocks({bool small = false}) async {
    final int stocksCount = Random().nextInt(5) + (small ? 0 : 5);

    for (int i = 0; i < stocksCount; i++) {
      final Currency one = allMockStocks[Random().nextInt(allMockStocks.length)];
      final Currency two = allMockCurencies.first;

      stocksSignals.insert(
        0,
        Signal(
          one: one,
          two: two,
          date: DateTime.now(),
          type: SignalType.values[Random().nextInt(SignalType.values.length)],
          period: SignalPeriod.values[Random().nextInt(SignalPeriod.values.length)],
        ),
      );
    }
  }

  Future<void> _generateCommodities({bool small = false}) async {
    final int commoditiesCount = Random().nextInt(5) + (small ? 0 : 5);

    for (int i = 0; i < commoditiesCount; i++) {
      final Currency one = allMockCommodities[Random().nextInt(allMockCommodities.length)];
      final Currency two = allMockCurencies.first;

      commoditySignals.insert(
        0,
        Signal(
          one: one,
          two: two,
          date: DateTime.now(),
          type: SignalType.values[Random().nextInt(SignalType.values.length)],
          period: SignalPeriod.values[Random().nextInt(SignalPeriod.values.length)],
        ),
      );
    }
  }

  Future<void> _generateCurrencies({bool small = false}) async {
    final int currenciesCount = Random().nextInt(5) + (small ? 0 : 5);

    for (int i = 0; i < currenciesCount; i++) {
      final Currency one = allMockCurencies[Random().nextInt(allMockCurencies.length)];
      final Currency two = allMockCurencies
          .where((e) => e != one)
          .toList()[Random().nextInt(allMockCurencies.where((e) => e != one).toList().length)];

      currencySignals.insert(
        0,
        Signal(
          one: one,
          two: two,
          date: DateTime.now(),
          type: SignalType.values[Random().nextInt(SignalType.values.length)],
          period: SignalPeriod.values[Random().nextInt(SignalPeriod.values.length)],
        ),
      );
    }
  }

  Future<void> _generateData({bool small = false}) async {
    await _generateStocks(small: small);
    await _generateCommodities(small: small);
    await _generateCurrencies(small: small);

    service<Settings>().signalsData = SignalsData(
      stockSignals: stocksSignals,
      currencySignals: currencySignals,
      commoditySignals: commoditySignals,
      lastUpdate: lastUpdate,
    );
  }

  Future<void> _clearData() async {
    stocksSignals.clear();
    commoditySignals.clear();
    currencySignals.clear();
  }

  Future<void> _handleDataUpdate() async {
    print('Время с последнего обновления: ${(DateTime.now().difference(lastUpdate)).inMinutes} min');
    _generateData(small: stocksSignals.isNotEmpty);

    if ((DateTime.now().difference(lastUpdate)).inMinutes >= _fullUpdateCycles * _updatePeriod.inMinutes) {
      lastUpdate = DateTime.now();
      await _clearData();
      await _generateData();
    }
  }

  Future<void> _loadCachedData() async {
    try {
      final SignalsData data = service<Settings>().signalsData;

      stocksSignals = data.stockSignals.asObservable();
      commoditySignals = data.commoditySignals.asObservable();
      currencySignals = data.currencySignals.asObservable();
      lastUpdate = data.lastUpdate;
    } catch (_) {}
  }

  Future<void> initialize() async {
    await _loadCachedData();

    // Если данные не загружены, то генерируем начальные.
    if (stocksSignals.isEmpty || commoditySignals.isEmpty || currencySignals.isEmpty) {
      _handleDataUpdate();
    }

    Stream.periodic(_updatePeriod).listen((_) => _handleDataUpdate());
  }
}
