import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quotex/internal/services/helpers.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/states/bottom_app_bar_state/bottom_app_bar_state.dart';
import 'package:quotex/internal/states/subscription_state/subscription_state.dart';
import 'package:quotex/internal/utils/infrastructure.dart';
import 'package:quotex/presentation/global/loader/q_loader.dart';

class PremiumScreenView extends StatefulWidget {
  const PremiumScreenView({Key? key}) : super(key: key);

  @override
  State<PremiumScreenView> createState() => _PremiumScreenViewState();
}

class _PremiumScreenViewState extends State<PremiumScreenView> {
  /// Оформляется подписка или нет.
  bool isLoading = false;

  Widget _buildImage(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Image.asset(
          'assets/premium.png',
          fit: BoxFit.contain,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text.rich(
              TextSpan(
                style: TextStyle(fontSize: 27.w, color: whiteColor, fontWeight: FontWeight.bold),
                children: [
                  const TextSpan(text: 'Be up-to-date\n'),
                  TextSpan(
                    text: 'Unlimited access',
                    style: TextStyle(fontSize: 27.w, color: greenColor, fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(text: ' to all trading signals'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });

        final bool result = await service<SubscriptionState>().subscribe();

        setState(() {
          isLoading = false;
        });

        if (result) {
          /// Переход на главную страницу.
          service<BottomAppBarState>().changePage(0);
        }
      },
      child: Ink(
        height: 52.h,
        width: MediaQuery.of(context).size.width - 2 * 16.w,
        decoration: BoxDecoration(borderRadius: borderRadius8, color: greenColor),
        child: Center(
          child: Text(
            'Subscribe for \$11.99/month',
            style: TextStyle(fontSize: 19.w, fontWeight: FontWeight.bold, color: whiteColor),
          ),
        ),
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: blackColor.withOpacity(0.3),
      child: const Center(
        child: QLoader(),
      ),
    );
  }

  Widget _buildPrivacyTermsRestore(BuildContext context) {
    final TextStyle style = TextStyle(fontSize: 15.w, fontWeight: FontWeight.w400, color: whiteColor);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => openTerms(),
              child: Center(
                child: Text('Terms of Use', style: style),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                final bool result = await service<SubscriptionState>().restore();

                setState(() {
                  isLoading = false;
                });

                if (result) {
                  /// Переход на главную страницу.
                  service<BottomAppBarState>().changePage(0);
                }
              },
              child: Center(
                child: Text('Restore', style: style),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => openPrivacy(),
              child: Center(
                child: Text('Privacy Policy', style: style),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _buildImage(context),
        ),
        SizedBox(height: 16.h),
        _buildButton(context),
        SizedBox(height: 16.h),
        _buildPrivacyTermsRestore(context),
        SizedBox(height: 16.h)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Premium',
          style: TextStyle(fontSize: 19.w, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          _buildContent(context),
          if (isLoading) _buildLoader(context),
        ],
      ),
    );
  }
}
