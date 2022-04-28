import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xff4b152c),
            const Color(0xff27163b).withOpacity(0.8),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.transparent,
        ),
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: const [
                      CircleAvatar(
                        radius: 120,
                        backgroundImage: AssetImage('assets/images/tosegar.png'),
                        backgroundColor: Colors.transparent,
                      ),
                      Text(
                        'توسعه گر',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Kalameh_bold',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextButton(
                  onPressed: () {
                    onButtonPressed(context);
                  },
                  child: const Text(
                    'درباره نرم افزار',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Kalameh',
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: TextButton(
                  onPressed: () {
                    launch('https://mohsenmodhej.com/vip99/');
                  },
                  child: const Text(
                    'ثبت نام در  دوره توسعه گر',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Kalameh',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  onButtonPressed(context) {
    Navigator.pop(context);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'این اپ فقط برای نمایش کیفیت پروژه های آموزشی دوره جامع توسعه‌گر ساخته شده است',
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xff27163b).withOpacity(1),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontFamily: 'Kalameh',
          ),
        );
      },
    );
  }
}
