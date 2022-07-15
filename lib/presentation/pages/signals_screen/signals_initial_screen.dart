import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/states/signals_screen_state/signals_screen_state.dart';
import 'package:quotex/internal/utils/infrastructure.dart';

class SignalsInitialScreen extends StatefulWidget {
  const SignalsInitialScreen({
    Key? key,
    required this.navigatorKey,
    required this.onChangedRoute,
  }) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;
  final Function(String) onChangedRoute;

  @override
  State<SignalsInitialScreen> createState() => _SignalsInitialScreenState();
}

class _SignalsInitialScreenState extends State<SignalsInitialScreen> {
  List<Widget> _buttons(BuildContext context) => [
        _buildButton(
          context,
          title: 'Currencies',
          description: 'EUR, USD and many others',
          image: 'assets/currencies.png',
          route: SignalsScreenState.currenciesRoute,
        ),
        _buildButton(
          context,
          title: 'Commodities',
          description: 'Gold, silver, brent, crude',
          image: 'assets/commodities.png',
          route: SignalsScreenState.commoditiesRoute,
        ),
        _buildButton(
          context,
          title: 'Stocks',
          description: 'Pfizer Inc, McDonalds and others',
          image: 'assets/stocks.png',
          route: SignalsScreenState.stocksRoute,
        ),
      ];

  Widget _buildButton(BuildContext context,
      {required String route, required String title, required String description, required String image}) {
    return InkWell(
      onTap: () {
        widget.navigatorKey.currentState!.pushNamed(route);
        service<SignalsScreenState>().route = route;

        widget.onChangedRoute(route);
      },
      borderRadius: borderRadius8,
      child: Ink(
        height: 88.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: borderRadius8,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 19.w, fontWeight: FontWeight.bold, color: whiteColor),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11.w, fontWeight: FontWeight.w400, color: whiteColor.withOpacity(0.3)),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset(image, height: 56.r, width: 56.r),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      itemBuilder: (context, index) {
        return _buttons(context).elementAt(index);
      },
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemCount: _buttons(context).length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }
}
