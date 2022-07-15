import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart' as svg;
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';
import 'package:quotex/domain/models/signal/signal.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/states/subscription_state/subscription_state.dart';
import 'package:quotex/internal/utils/infrastructure.dart';

class SignalWrapper extends StatelessWidget {
  const SignalWrapper({
    Key? key,
    required this.signal,
    this.onlyFirst = false,
  }) : super(key: key);

  final Signal signal;

  final bool onlyFirst;

  Widget _buildPremiumPlate(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 24.0,
          child: Center(
            child: Text(
              'Premium',
              style: TextStyle(fontSize: 15.w, height: 17.25.w / 15.w, color: whiteColor),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        const Icon(Icons.lock_outline_rounded, color: whiteColor),
      ],
    );
  }

  Widget _buildImages(BuildContext context) {
    return SizedBox(
      width: 64.w,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: ClipRRect(
              borderRadius: borderRadius32,
              child: Container(
                height: 36.r,
                width: 36.r,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: backgroundColor, width: 2.0),
                  image: DecorationImage(
                    image: (signal.one.image.contains('svg') ? Svg(signal.one.image) : AssetImage(signal.one.image))
                        as ImageProvider,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 28.w),
            child: ClipRRect(
              borderRadius: borderRadius32,
              child: Container(
                height: 36.r,
                width: 36.r,
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: backgroundColor, width: 2.0),
                  image: DecorationImage(
                    image: (signal.two.image.contains('svg') ? Svg(signal.two.image) : AssetImage(signal.two.image))
                        as ImageProvider,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignalInfo(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 24.0,
          child: Center(
            child: Text(
              signal.period.asString,
              style: TextStyle(
                  fontSize: 15.w, height: 17.25.w / 15.w, color: signal.type == SignalType.up ? greenColor : redColor),
            ),
          ),
        ),
        SizedBox(width: 4.w),
        Icon(
          signal.type == SignalType.up ? Icons.arrow_upward : Icons.arrow_downward,
          color: signal.type == SignalType.up ? greenColor : redColor,
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildImages(context),
          SizedBox(width: 12.w),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                onlyFirst ? signal.one.title : '${signal.one.title}/${signal.two.title}',
                style: TextStyle(fontSize: 15.w, color: whiteColor),
              ),
              SizedBox(height: 4.h),
              Text(
                // '12 June 2022, 18:27',

                DateFormat('dd MMM yyyy, HH:mm').format(signal.date),
                style: TextStyle(fontSize: 11.w, color: whiteColor.withOpacity(0.3)),
              ),
            ],
          ),
          const Spacer(),
          if (signal.period == SignalPeriod.m_1 ||
              signal.period == SignalPeriod.m_2 ||
              signal.period == SignalPeriod.m_3 ||
              service<SubscriptionState>().isSubscribed)
            _buildSignalInfo(context)
          else
            _buildPremiumPlate(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64.h,
      child: _buildContent(context),
    );
  }
}
