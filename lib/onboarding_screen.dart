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
import 'package:flutter_onboarding/bloc/timer/timer_cubit.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> with SingleTickerProviderStateMixin {
  final _initialPageIndex = 0;
  late PageController _pageController;

  late final fadeAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  );
  late final fadeAnimation = Tween(begin: 1.0, end: 0.0).animate(fadeAnimationController);

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: _initialPageIndex);

    BlocProvider.of<OnboardingBloc>(context)
        .add(ChangePageEvent(newPage: testData.first, newPageIndex: _initialPageIndex));

    BlocProvider.of<TimerCubit>(context).startTimer();
  }

  @override
  void dispose() {
    BlocProvider.of<TimerCubit>(context).stopTimer();
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
                onTapDown: (details) async {
                  final width = MediaQuery.of(context).size.width;

                  if (details.globalPosition.dx < width / 5 && state.pageIndex > 0) {
                    fadeAnimationController.forward();
                    await _pageController.previousPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  }

                  if (details.globalPosition.dx > width - width / 5) {
                    if (state.pageIndex != testData.length - 1) {
                      fadeAnimationController.forward();
                      await _pageController.nextPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      exit(0);
                    }
                  }
                },
                onPanUpdate: (details) async {
                  // Swiping in right direction.
                  if (details.delta.dx < 0) {
                    if (state.pageIndex != testData.length - 1) {
                      fadeAnimationController.forward();
                      await _pageController.nextPage(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      exit(0);
                    }
                  }

                  // Swiping in left direction.
                  if (details.delta.dx > 0 && state.pageIndex > 0) {
                    fadeAnimationController.forward();
                    await _pageController.previousPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                onLongPressStart: (details) {
                  // pause timer
                  BlocProvider.of<TimerCubit>(context).pauseTimer();
                },
                onLongPressEnd: (details) {
                  // start timer
                  BlocProvider.of<TimerCubit>(context).startTimer();
                },
                child: AnimatedContainer(
                  decoration: BoxDecoration(
                    gradient: state.pageData?.bgGradient,
                  ),
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: SafeArea(
                    child: Column(
                      children: [
                        const SizedBox(height: 4),
                        _Header(
                          pageIndex: state.pageIndex,
                          animationController: fadeAnimationController,
                          pageController: _pageController,
                        ),
                        const SizedBox(height: 29),
                        Flexible(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxHeight: 311, maxWidth: 381),
                            child: PageView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              controller: _pageController,
                              itemCount: testData.length,
                              onPageChanged: (index) {
                                fadeAnimationController.reverse();
                                BlocProvider.of<OnboardingBloc>(context).add(
                                    ChangePageEvent(newPage: testData[index], newPageIndex: index));
                                BlocProvider.of<TimerCubit>(context)
                                    .resetTimer(pageIndex: index.toDouble());
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
                                  if (state.pageData case OnBoardingModel model) ...[
                                    BaseText(
                                      text: model.title,
                                      baseTextStyle: BaseTextStyle.headline,
                                    ),
                                    const SizedBox(height: 13),
                                    if (model.description case String description)
                                      BaseText(text: description),
                                    const SizedBox(height: 10),
                                  ],
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
  final PageController pageController;
  final AnimationController animationController;

  const _Header({
    required this.pageIndex,
    required this.pageController,
    required this.animationController,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TimerCubit, TimerState>(
      listener: (context, state) async {
        if (state is TimerStop) {
          if (pageController.page == testData.length - 1 && context.mounted) {
            BlocProvider.of<TimerCubit>(context).stopTimer();
            exit(0);
          }

          animationController.forward();

          await pageController.nextPage(
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOut,
          );

          if (context.mounted) {
            BlocProvider.of<TimerCubit>(context).resetTimer(pageIndex: pageController.page!);
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...List.generate(testData.length, (index) {
                return Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: index < testData.length - 1 ? 4 : 0),
                  child: state.pageIndex > index
                      ? const Indicator(value: 1)
                      : Indicator(value: state.pageIndex == index ? state.indicatorValue : 0),
                ));
              }),
              SvgButton(
                  asset: SvgIcons.close,
                  onTap: () {
                    exit(0);
                  }),
            ],
          ),
        );
      },
    );
  }
}
