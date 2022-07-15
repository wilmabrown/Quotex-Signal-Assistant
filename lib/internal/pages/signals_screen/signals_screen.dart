import 'package:flutter/material.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/states/signals_screen_state/signals_screen_state.dart';
import 'package:quotex/presentation/pages/signals_screen/signals_screen_view.dart';

class SignalsScreen extends StatelessWidget {
  const SignalsScreen({Key? key}) : super(key: key);

  SignalsScreenState get state => service<SignalsScreenState>();

  @override
  Widget build(BuildContext context) {
    return SignalsScreenView(
      route: state.route,
    );
  }
}
