import 'package:flutter/material.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:weather_app/widgets/comfort_level.dart';
import 'package:weather_app/widgets/header_widget.dart';
import 'package:weather_app/widgets/hourly_data_widget.dart';

import '../widgets/current_weather_widget.dart';
import '../widgets/daily_data_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalController globalController =
      Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Пока идет получение данных о геолокации показывается индикатор загрузки
        // После загрузки показывает весь остальной интерфейс
        child: Obx(() => globalController.checkLoading().isTrue
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('WEATHER', style: TextStyle(
                      fontSize: 26,
                      color: CustomColors.firstGradientColor
                    ),),
                    Image.asset(
                      'assets/icons/clouds.png',
                      height: 200,
                      width: 200,
                    ),
                    const CircularProgressIndicator()
                  ],
                ),
              )
            : ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  // City and date
                  const HeaderWidget(),
                  // Current temp
                  CurrentWeatherWidget(
                    weatherDataCurrent:
                        globalController.getWeatherData().getCurrentWeather(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Hourly
                  HourlyDataWidget(
                    weatherDataHourly:
                        globalController.getWeatherData().getHourlyWeather(),
                  ),
                  // Daily
                  DailyDataWidget(
                    weatherDataDaily:
                        globalController.getWeatherData().getDailyWeather(),
                  ),
                  Container(
                    height: 1,
                    color: CustomColors.dividerLine,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ComfortLevel(
                      weatherDataCurrent:
                          globalController.getWeatherData().getCurrentWeather())
                ],
              )),
      ),
    );
  }
}
