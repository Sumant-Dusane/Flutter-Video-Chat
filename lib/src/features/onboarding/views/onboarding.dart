import 'package:flutter/material.dart';
import 'package:video_chat/src/common_widgets/large_text.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _Onboarding();
}

class _Onboarding extends State<Onboarding> {
  List images = [
    "onboarding-two.png",
    "onboarding-one.png"
  ];
  List texts = [
    {
      'main': 'Video Chat Application',
      'sub': 'Powered by webRTC'
    },
    {
      'main': 'Made in Flutter',
      'sub': 'Free For All'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        itemBuilder: (_, index) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/" + images[index],
                ),
                fit:  BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 80, left: 20, right: 20),
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LargeText(text: texts[index]['main'], color: Colors.brown.shade800),
                      LargeText(text: texts[index]['sub'], color: Colors.red.shade800, size: 25, fontWeight: FontWeight.w300),
                      const SizedBox(height: 10),
                      if (index == images.length-1 ) ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/dashboard'),
                        child: const Text("Continue")
                      ) 
                    ],
                  ),
                  Column(
                    children: List.generate(images.length, (indexDots){ 
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: 8,
                        height: index == indexDots ? 25 :8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: index == indexDots ? Colors.blueGrey : Colors.blueGrey.withOpacity(0.5)
                        ),
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
