import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/states/generate_data_state/generate_data_state.dart';
import 'package:quotex/presentation/global/signal_wrapper/signal_wrapper.dart';

class SignalsCommoditiesScreen extends StatelessWidget {
  const SignalsCommoditiesScreen({Key? key}) : super(key: key);

  GenerateDataState get state => service<GenerateDataState>();

  Widget _buildContent(BuildContext context) {
    return Observer(
      builder: (context) => ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        itemCount: state.commoditySignals.length,
        itemBuilder: (context, index) => SignalWrapper(
          signal: state.commoditySignals.elementAt(index),
          onlyFirst: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(context),
    );
  }
}
