import 'package:mobx/mobx.dart';

part 'signals_screen_state.g.dart';

class SignalsScreenState extends _SignalsScreenStateBase with _$SignalsScreenState {
  static const String initialRoute = '/signals';

  static const String currenciesRoute = '$initialRoute/currencies';
  static const String commoditiesRoute = '$initialRoute/commodities';
  static const String stocksRoute = '$initialRoute/stocks';
}

abstract class _SignalsScreenStateBase with Store {
  @observable
  String route = SignalsScreenState.initialRoute;
}
