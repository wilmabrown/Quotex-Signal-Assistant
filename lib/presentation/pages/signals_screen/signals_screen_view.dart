import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotex/internal/states/signals_screen_state/signals_screen_state.dart';
import 'package:quotex/internal/utils/infrastructure.dart';
import 'package:quotex/presentation/pages/signals_screen/signals_commodities_screen.dart';
import 'package:quotex/presentation/pages/signals_screen/signals_currencies_screen.dart';
import 'package:quotex/presentation/pages/signals_screen/signals_initial_screen.dart';
import 'package:quotex/presentation/pages/signals_screen/signals_stocks_screen.dart';

class SignalsScreenView extends StatefulWidget {
  const SignalsScreenView({
    Key? key,
    required this.route,
  }) : super(key: key);

  final String route;

  @override
  State<SignalsScreenView> createState() => _SignalsScreenViewState();
}

class _SignalsScreenViewState extends State<SignalsScreenView> {
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  static Map<String, String> get _routeToAppBarTitle => {
        SignalsScreenState.initialRoute: 'Signals',
        SignalsScreenState.currenciesRoute: 'Currencies',
        SignalsScreenState.commoditiesRoute: 'Commodities',
        SignalsScreenState.stocksRoute: 'Stocks',
      };

  String appBarTitle = _routeToAppBarTitle.values.first;

  @override
  void initState() {
    if (widget.route != SignalsScreenState.initialRoute) {
      appBarTitle = _routeToAppBarTitle[widget.route] ?? _routeToAppBarTitle.values.first;
    }

    super.initState();
  }

  void onChangedRoute(String route) {
    setState(() {
      appBarTitle = _routeToAppBarTitle[route] ?? appBarTitle;
    });
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;

    switch (settings.name) {
      case SignalsScreenState.currenciesRoute:
        page = const SignalsCurrenciesScreen();
        break;
      case SignalsScreenState.commoditiesRoute:
        page = const SignalsCommoditiesScreen();
        break;
      case SignalsScreenState.stocksRoute:
        page = const SignalsStocksScreen();
        break;
      case SignalsScreenState.initialRoute:
      default:
        page = SignalsInitialScreen(
          navigatorKey: _navigatorKey,
          onChangedRoute: onChangedRoute,
        );
        break;
    }

    return MaterialPageRoute(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  Widget _buildLeading(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigatorKey.currentState!.pop();
        onChangedRoute(SignalsScreenState.initialRoute);
      },
      child: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: appBarTitle != _routeToAppBarTitle[SignalsScreenState.initialRoute] ? _buildLeading(context) : null,
        title: Text(
          appBarTitle,
          style: TextStyle(fontSize: 19.w, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget.route,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
}
