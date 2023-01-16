// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:switch_theme/constant/constant.dart';

import '../app_theme.dart';
import 'component/wire_draw.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Offset initialPosition = const Offset(250, 0);
  Offset switchPosition = const Offset(350, 350);
  Offset containerPosition = const Offset(350, 350);
  Offset finalPosition = const Offset(350, 350);

  @override
  void didChangeDependencies() {
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    initialPosition = Offset(size.width * .9, 0);
    containerPosition = Offset(size.width * .9, size.height * .4);
    finalPosition = Offset(size.width * .9, size.height * .5 - size.width * .1);
    if (themeProvider.isLightTheme) {
      switchPosition = containerPosition;
    } else {
      switchPosition = finalPosition;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          center: const Alignment(-0.8, -0.3),
          radius: 1,
          colors: themeProvider.themeMode().gredientColor!,
        )),
        child: Stack(
          fit: StackFit.expand,
          children: [
            SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '12',
                    // DateTime.now().hour.toString(),
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    width: size.width * .2,
                    child: Divider(
                      height: 0,
                      thickness: 1,
                      color: AppColor.white,
                    ),
                  ),
                  Text(
                    DateTime.now().minute.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: AppColor.white),
                  ),
                  const Spacer(),
                  Text(
                    "Light Dark\nPersonal\nSwitch",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                    width: size.width * .2,
                    height: size.width * .2,
                    decoration: BoxDecoration(
                        color: themeProvider.themeMode().switchColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Icon(
                      Icons.nights_stay_outlined,
                      size: 50,
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(
                    width: size.width * .2,
                    child: const Divider(
                      // height: 0,
                      thickness: 1,
                      color: AppColor.white,
                    ),
                  ),
                  Text(
                    "30\u00B0C",
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: AppColor.white),
                  ),
                  Text(
                    "Clear",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    DateFormat('EEEE').format(DateTime.now()),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Text(
                    DateFormat('MMMM D').format(DateTime.now()),
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            )),
            Positioned(
                top: containerPosition.dy - size.width * .1 / 2 - 5,
                left: containerPosition.dx - size.width * .1 / 2 - 5,
                child: Container(
                    width: size.width * .1 + 10,
                    height: size.height * .1 + 10,
                    decoration: BoxDecoration(
                        color: themeProvider.themeMode().switchBgColor!,
                        borderRadius: BorderRadius.circular(30)))),
            Wire(
              initialPosition: initialPosition,
              toOffset: switchPosition,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 0),
              top: switchPosition.dy - size.width * .1 / 2,
              left: switchPosition.dx - size.width * .1 / 2,
              child: Draggable(
                feedback: Container(
                    width: size.width * .1,
                    height: size.width * 1,
                    decoration: BoxDecoration(
                        color: Colors.transparent, shape: BoxShape.circle)),
                onDragEnd: (details) {
                  if (themeProvider.isLightTheme) {
                    setState(() {
                      switchPosition = containerPosition;
                    });
                  } else {
                    setState(() {
                      switchPosition = finalPosition;
                    });
                  }
                  themeProvider.toggleThemeData();
                },
                onDragUpdate: (details) {
                  setState(() {
                    switchPosition = details.localPosition;
                  });
                },
                child: Container(
                  width: size.width * .1,
                  height: size.width * .1,
                  decoration: BoxDecoration(
                      color: themeProvider.themeMode().thumColor,
                      border: Border.all(
                        width: 5,
                        color: themeProvider.themeMode().switchColor!,
                      ),
                      shape: BoxShape.circle),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
