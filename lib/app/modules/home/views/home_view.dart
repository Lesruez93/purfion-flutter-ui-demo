import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:relative_scale/relative_scale.dart';

import '../controllers/home_controller.dart';

// Created on 11/04/2023
// By Lester Rusike


class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        backgroundColor: const Color(0xFFDBDBDB),
        appBar: AppBar(
          backgroundColor: const Color(0xFFDBDBDB),
          title: Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Obx(() => DropdownButton<String>(
                    value: controller.room.value,
                    onChanged: (String? newValue) {
                      controller.room.value = newValue!;
                    },
                    items: <String>[
                      'Living Room',
                      'Bedroom',
                      'Kitchen',
                      'Bathroom',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      );
                    }).toList(),
                  ))),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.settings_outlined,
                size: 25,
              ),
            )
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: sx(300),
                  height: sy(200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF264063),
                        Color(0xFF45566C),
                        Color(0xFF264063),
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.lightBlueAccent,
                              width: 4.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: sy(65)),
                        child: Center(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.cloud_outlined,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    'AQI',
                                    style: TextStyle(
                                        fontSize: sy(12.0),
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Obx(() => Text(
                                    '0 ${controller.timerNumber}',
                                    style: const TextStyle(
                                        fontSize: 40.0,
                                        fontFamily: 'DigitalFont',
                                        //fontWeight: FontWeight.bold,

                                        color: Colors.white),
                                  )),
                              const SizedBox(width: 10.0),
                              const Text(
                                'GOOD',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                _buildDeviceStatus(),
                _buildClimateControls(),
                const SizedBox(height: 20),
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
        drawer: const Drawer(),
      );
    });
  }

  Widget _buildDeviceStatus() {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('AI'),
        ),
        title: const Text(
          style: TextStyle(fontWeight: FontWeight.bold),
          'Purification Deluxe',
        ),
        subtitle: const Text('Device Online'),
        trailing: Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0)),
          child: SizedBox(
            width: 60,
            height: 35,
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(CupertinoIcons.battery_25_percent),
                    Text(
                      '54%',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                LinearProgressIndicator(
                  value: 0.58,
                  minHeight: 5,
                  borderRadius: BorderRadius.circular(8.0),
                  // Adjust based on actual percentage
                  backgroundColor: Colors.green[100],
                  valueColor: const AlwaysStoppedAnimation(Colors.green),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClimateControls() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text('FAN'),
              SizedBox(
                height: 5,
              ),
              Text(
                '8s',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Column(
            children: [
              const Text('FILTER LIFE'),
              const SizedBox(
                height: 5,
              ),
              Obx(() => Text(
                    '${controller.filterLife.toString()}%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Column(
            children: [
              const Text('HUMIDITY'),
              const SizedBox(
                height: 5,
              ),
              Obx(() => Text(
                    '${controller.humidity}%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
          Column(
            children: [
              const Text('TEMP'),
              const SizedBox(
                height: 5,
              ),
              Obx(() => Text(
                    '${controller.temp}°',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.power,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    const Text(
                      'ON',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
                child: VerticalDivider(),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.mode_fan_off_outlined,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'SPEED',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
                child: VerticalDivider(),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.lightbulb,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'AUTO',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: Container(
              width: 500,
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.grey.withOpacity(0.1),
                    // Transparent color at the left
                    Colors.grey,
                    // Bright color in the middle
                    Colors.grey.withOpacity(0.1),
                    // Transparent color at the right
                  ],
                  stops: const [
                    0.2,
                    0.4,
                    2
                  ], // Adjust the stops for the fade effect
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    IconButton(
                      icon: const Icon(
                        CupertinoIcons.clock,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    const Text(
                      'TIMER',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 70,
                child: VerticalDivider(),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.bar_chart_outlined,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'STATS',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const SizedBox(
                height: 50,
                child: VerticalDivider(),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.moon,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  const Text(
                    'NIGHT',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
