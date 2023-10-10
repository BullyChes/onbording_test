import 'package:flutter/material.dart';
import 'package:flutter_onboarding/UI/Assets/images.dart';
import 'package:flutter_onboarding/UI/Style/base_colors.dart';

class OnBoardingModel {
  final String title, assetName;
  final String? description;
  final Color? bgColor;
  final LinearGradient? bgGradient;
  final bool withActionButtons;

  OnBoardingModel({
    required this.title,
    required this.assetName,
    this.description,
    this.bgColor,
    this.bgGradient,
    this.withActionButtons = true,
  });
}

final List<OnBoardingModel> testData = [
  OnBoardingModel(
    title: 'Нам важно ваше мнение! Оцените изменения в Simpler',
    assetName: Images.page1,
    bgColor: BaseColors.blue,
    withActionButtons: false,
  ),
  OnBoardingModel(
    title: 'Включите тёмную тему',
    description:
        'Занимайтесь английским даже ночью или просто посмотрите как изменится ваш интерфейс!',
    assetName: Images.page2,
    bgColor: BaseColors.darkGrey,
  ),
  OnBoardingModel(
    title: 'Соревнуйтесь в рейтинге космонавтов',
    description:
        'Зарабатывайте очки и продвигайтесь к вершине! Займите место в ракете и изучите новые созвездия',
    assetName: Images.page3,
    bgColor: BaseColors.orange,
  ),
  OnBoardingModel(
    title: 'Раскройте преступления и станьте комиссаром',
    description:
        'Обновлённые детективные истории дают вам новый опыт в расследовании детективных дел',
    assetName: Images.page4,
    bgColor: BaseColors.red,
  ),
  OnBoardingModel(
    title: 'Тренируйте язык с помощью новых заданий',
    description:
        'Чем больше уроков вы пройдёте, тем больше уникальных заданий станет доступно для тренировки ваших навыков',
    assetName: Images.page5,
    bgGradient: BaseColors.greenGradient,
  ),
];

class OnBoardingPage extends StatelessWidget {
  final OnBoardingModel item;

  const OnBoardingPage({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Image.asset(
        item.assetName,
        // width: 381,
        // fit: BoxFit.fitWidth,
      ),
    );
  }
}
