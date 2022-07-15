// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:quotex/internal/services/service_locator.dart';
import 'package:quotex/internal/states/bottom_app_bar_state/bottom_app_bar_state.dart';
import 'package:quotex/internal/states/generate_data_state/generate_data_state.dart';
import 'package:quotex/presentation/global/bottom_app_bar/bottom_app_bar.dart' as b;
import 'package:quotex/presentation/global/bottom_app_bar/bottom_app_bar_item.dart';

class Workspace extends StatefulWidget {
  const Workspace({Key? key}) : super(key: key);

  static const routeName = '/workspace';

  @override
  State<Workspace> createState() => _WorkspaceState();
}

class _WorkspaceState extends State<Workspace> {
  BottomAppBarState get bottomAppBarState => service<BottomAppBarState>();

  @override
  void initState() {
    Future.wait([
      service<GenerateDataState>().initialize(),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) => Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: bottomAppBarState.pageController,
          children: bottomAppBarState.pages,
        ),
        bottomNavigationBar: b.BottomAppBar(
          currentIndex: bottomAppBarState.currentIndex,
          items: bottomAppBarState.items,
          onPageChanged: bottomAppBarState.changePage,
        ),
      ),
    );
  }
}
