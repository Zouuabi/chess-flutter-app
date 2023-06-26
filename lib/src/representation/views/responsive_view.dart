import 'package:flutter/material.dart';

import 'package:chess/src/representation/resources/color_manager.dart';
import 'package:chess/src/representation/resources/constants_manager.dart';
import 'package:chess/src/representation/views/board/view/board_view.dart';
import 'package:chess/src/representation/views/board/view/components.dart';

class ResponsiveView extends StatelessWidget {
  const ResponsiveView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > ConstantsManager.webScreenSize) {
        return const WebView();
      } else {
        return const MobileView();
      }
    });
  }
}

class MobileView extends StatelessWidget {
  const MobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: getAppBar(),
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [UserCard(), TimeIndicator()],
              )),
          Flexible(
              flex: 6,
              child: SizedBox(
                height: 400,
                width: 400,
                child: BoardView(),
              )),
          Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [UserCard(), TimeIndicator()],
              )),
        ],
      ),
    );
  }
}

class WebView extends StatelessWidget {
  const WebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Row(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                height: double.infinity,
              )),
          const Flexible(
            flex: 4,
            child: Column(
              children: [
                Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [UserCard(), TimeIndicator()],
                    )),
                Flexible(
                    flex: 6,
                    child: SizedBox(
                      height: 500,
                      width: 500,
                      child: BoardView(),
                    )),
                Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [UserCard(), TimeIndicator()],
                    )),
              ],
            ),
          ),
          Flexible(
              flex: 2,
              child: Container(
                height: double.infinity,
              )),
        ],
      ),
    );
  }
}
