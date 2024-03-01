import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:video_chat/src/features/video_meet/views/video_call.dart';
import 'package:video_chat/src/utils/meet_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? meetKey;
  MeetHelper meetHelper = MeetHelper();
  TextEditingController existingMeetKeyController = TextEditingController();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();

  void setMeetKey(String key) {
    setState(() {
      meetKey = key;
    });
  }

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    meetHelper.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () async {
                    // meetKey = await meetHelper.newMeet(_remoteRenderer);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VideoCall(localRenderer: _localRenderer, remoteRenderer: _remoteRenderer, isNew: true))
                    );
                  },
                  child: const Text('New Meeting'),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: (){
                    _displayBottomSheet(context);
                  },
                  child: const Text('Join Meeting')
                ),
              ],
            ),
            const Divider(
              height: 30,
              thickness: 1,
              indent: 25,
              endIndent: 25,
            ),
            const Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text('History'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }


  Future _displayBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context, 
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      isDismissible: false,
      barrierColor: Colors.black87.withOpacity(0.5),
      backgroundColor: Colors.white,
      builder: (context) => Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'JOIN MEET',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24
                    ),
                  ),
                  IconButton.filledTonal(
                    onPressed: () {
                      Navigator.pop(context);
                    }, 
                    icon: const Icon(
                      Icons.close
                    )
                  ),
                ],
              ),
              const SizedBox(height: 35),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Meet Key',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.key_outlined,
                  )
                ),
                controller: existingMeetKeyController,
                onChanged: (value) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 25),
              FilledButton(
                style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(
                    Size(double.maxFinite, 54)
                  ),
                ),
                onPressed: () async {
                  // await meetHelper.joinMeet(existingMeetKeyController.text, _remoteRenderer);
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => VideoCall(localRenderer: _localRenderer, remoteRenderer: _remoteRenderer, isNew: false, meetKey: existingMeetKeyController.text))
                  );
                },
                child: const Text('Join Meet'),
              ),
            ],
          ),
        )
      ),
    );
  }
}


// cPWgPOVfIYraP57XkGZr