import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quotex/internal/services/helpers.dart';
import 'package:quotex/internal/services/settings.dart';
import 'package:quotex/internal/utils/infrastructure.dart';
import 'package:quotex/presentation/global/icons/q_icons.dart';
import 'package:share_plus/share_plus.dart';

class SettingsScreenView extends StatelessWidget {
  const SettingsScreenView({Key? key}) : super(key: key);

  List<Widget> _buttons(BuildContext context) => [
        _buildButton(
          context,
          title: 'Privacy Policy',
          icon: QIcons.privacy,
          onTap: () => openPrivacy(),
        ),
        _buildButton(
          context,
          title: 'Terms of Use',
          icon: QIcons.terms,
          onTap: () => openTerms(),
        ),
        _buildButton(
          context,
          title: 'Rate app',
          icon: QIcons.rate,
          onTap: () => rateMyApp.showRateDialog(context),
        ),
        _buildButton(
          context,
          title: 'Share app',
          icon: QIcons.share,
          onTap: () => Share.share(Settings.appName),
        ),
        _buildButton(
          context,
          title: 'Support',
          icon: QIcons.support,
          onTap: () => openSupport(),
        ),
      ];

  Widget _buildButton(
    BuildContext context, {
    required String title,
    required String icon,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius8,
      child: Ink(
        height: 48.h,
        width: MediaQuery.of(context).size.width - 16.w,
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: borderRadius8,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              SvgPicture.asset(icon, height: 24.r, width: 24.r, color: whiteColor),
              SizedBox(width: 12.w),
              Text(
                title,
                style: TextStyle(fontSize: 15.w, color: whiteColor),
              ),
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
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: Text(
          'Settings',
          style: TextStyle(fontSize: 19.w, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: _buildContent(context),
    );
  }
}
