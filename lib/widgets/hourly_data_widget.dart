import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:weather_app/model/weather_data_hourly.dart';
import 'package:weather_app/utils/custom_colors.dart';

class HourlyDataWidget extends StatelessWidget {
  final WeatherDataHourly weatherDataHourly;

  HourlyDataWidget({Key? key, required this.weatherDataHourly})
      : super(key: key);

  RxInt cardIndex = GlobalController().getIndex();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          alignment: Alignment.topCenter,
          child: const Text(
            'Today',
            style: TextStyle(fontSize: 18),
          ),
        ),
        hourlyList(),
      ],
    );
  }

  Widget hourlyList() {
    return Container(
      height: 150,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: weatherDataHourly.hourly.length > 13
            ? 13
            : weatherDataHourly.hourly.length,
        itemBuilder: (context, index) {
          return Obx(() => GestureDetector(
              onTap: () {
                cardIndex.value = index;
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                width: 85,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.5, 0),
                        blurRadius: 30,
                        spreadRadius: 1,
                        color: CustomColors.dividerLine.withAlpha(150),
                      ),
                    ],
                    gradient: cardIndex.value == index
                        ? const LinearGradient(colors: [
                            CustomColors.firstGradientColor,
                            CustomColors.secondGradientColor
                          ])
                        : null),
                child: HourlyDetails(
                  index: index,
                  cardIndex: cardIndex.toInt(),
                  temp: weatherDataHourly.hourly[index].temp!,
                  timeStamp: weatherDataHourly.hourly[index].dt!,
                  weatherIcon:
                      weatherDataHourly.hourly[index].weather![0].icon!,
                ),
              )));
        },
      ),
    );
  }
}

class HourlyDetails extends StatelessWidget {
  int temp;
  int timeStamp;
  int index;
  int cardIndex;
  String weatherIcon;

  HourlyDetails(
      {Key? key,
      required this.temp,
      required this.timeStamp,
      required this.index,
      required this.cardIndex,
      required this.weatherIcon})
      : super(key: key);

  String getTime(final timeStamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    String result = DateFormat('jm').format(time);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: Text(
            getTime(timeStamp),
            style: TextStyle(
                color: cardIndex == index
                    ? Colors.white
                    : CustomColors.textColorBlack),
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Image.asset(
            'assets/weather/$weatherIcon.png',
            height: 40,
            width: 40,
          ),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: Text('$temp°C',
              style: TextStyle(
                  color: cardIndex == index
                      ? Colors.white
                      : CustomColors.textColorBlack)),
        )
      ],
    );
  }
}
