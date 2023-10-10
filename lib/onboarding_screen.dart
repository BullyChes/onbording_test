import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_onboarding/UI/Assets/svg_icons.dart';
import 'package:flutter_onboarding/UI/Base/base_button.dart';
import 'package:flutter_onboarding/UI/Base/base_text.dart';
import 'package:flutter_onboarding/UI/Base/indicator.dart';
import 'package:flutter_onboarding/UI/Base/svg_button.dart';
import 'package:flutter_onboarding/UI/Onboarding/onboarding.dart';
import 'package:flutter_onboarding/bloc/onboarding/onboarding_bloc.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with SingleTickerProviderStateMixin {
  final _initialPageIndex = 0;
  late PageController _pageController;
  // int _pageIndex = 0;
  Timer? _timer;

  late final fadeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(fadeAnimationController);

  @override
  void initState() {
    super.initState();

    BlocProvider.of<OnboardingBloc>(context)
        .add(ChangePageEvent(newPage: testData.first, newPageIndex: _initialPageIndex));

    _pageController = PageController(initialPage: _initialPageIndex);
    // _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
    //   if (_pageIndex < testData.length) {
    //     _pageIndex++;
    //   } else {
    //     // закрыть приложение
    //     exit(0);
    //   }

    //   _pageController.animateToPage(
    //     _pageIndex,
    //     duration: const Duration(milliseconds: 350),
    //     curve: Curves.easeInOut,
    //   );
    // });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // DecoratedBoxTransition
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        switch (state) {
          case OnboardingInitial():
            return Scaffold(
              body: GestureDetector(
                onTapDown: (details) {
                  print(details.globalPosition.dx);
                },
                onPanUpdate: (details) {
                  // Swiping in right direction.
                  if (details.delta.dx < 0 && state.pageIndex != testData.length - 1) {
                    fadeAnimationController.forward();
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  }
                  // Swiping in left direction.
                  if (details.delta.dx > 0 && state.pageIndex > 0) {
                    fadeAnimationController.forward();
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                onLongPressStart: (details) {
                  // pause timer
                },
                onLongPressEnd: (details) {
                  // start timer
                },
                child: Container(
                  // TODO(Nelli): сделать анимацию DecoratedBoxTransition. Смена состояния через bloc
                  decoration: BoxDecoration(
                    color: state.pageData?.bgColor,
                    gradient: state.pageData?.bgGradient,
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        _Header(pageIndex: state.pageIndex),
                        const SizedBox(height: 29),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 311, maxWidth: 381),
                            child: PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              itemCount: testData.length,
                              onPageChanged: (index) {
                                // _pageIndex = index;
                                BlocProvider.of<OnboardingBloc>(context).add(
                                    ChangePageEvent(newPage: testData[index], newPageIndex: index));
                                fadeAnimationController.reverse();
                              },
                              itemBuilder: (context, index) {
                                return OnBoardingPage(item: testData[state.pageIndex]);
                              },
                            ),
                          ),
                        ),
                        FadeTransition(
                          opacity: fadeAnimation,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Flexible(
                              fit: FlexFit.tight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  BaseText(
                                    text: state.pageData!.title,
                                    baseTextStyle: BaseTextStyle.headline,
                                  ),
                                  const SizedBox(height: 13),
                                  if (state.pageData?.description case String description)
                                    BaseText(text: description),
                                  const SizedBox(height: 10),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            height: 70,
                            child: state.pageData != null
                                ? Visibility(
                                    visible: state.pageData!.withActionButtons,
                                    child: FadeTransition(
                                      opacity: fadeAnimation,
                                      child: Row(
                                        children: [
                                          BaseButton(
                                            asset: SvgIcons.dislike,
                                            onPressed: () {
                                              if (state.pageIndex > 0) {
                                                fadeAnimationController.forward();
                                                _pageController.previousPage(
                                                  duration: const Duration(milliseconds: 350),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            },
                                          ),
                                          const SizedBox(width: 17),
                                          BaseButton(
                                            asset: SvgIcons.like,
                                            onPressed: () {
                                              if (state.pageIndex != testData.length - 1) {
                                                fadeAnimationController.forward();
                                                _pageController.nextPage(
                                                  duration: const Duration(milliseconds: 350),
                                                  curve: Curves.easeInOut,
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
        }
      },
    );
  }
}

class _Header extends StatelessWidget {
  final int pageIndex;
  const _Header({required this.pageIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // TODO(Nelli): привязать к кубиту
          ...List.generate(testData.length, (index) {
            return Expanded(
                child: Padding(
              padding: EdgeInsets.only(right: index < testData.length - 1 ? 4 : 0),
              child: const Indicator(value: 0),
            ));
          }),

          // добавить кнопку
          SvgButton(
              asset: SvgIcons.close,
              onTap: () {
                exit(0);
              }),
        ],
      ),
    );
  }
}
