import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:video_chat/src/common_widgets/meet_details.dart';
import 'package:video_chat/src/utils/meet_helper.dart';

class VideoCall extends StatefulWidget {
  RTCVideoRenderer localRenderer;
  RTCVideoRenderer remoteRenderer;
  bool isNew;
  String? meetKey;
  
  VideoCall({
    super.key,
    required this.localRenderer,
    required this.remoteRenderer,
    required this.isNew,
    this.meetKey
  });

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  MeetHelper meetHelper = MeetHelper();
  bool showMeetDetails = true;

  @override
  void initState() {
    widget.localRenderer.initialize();
    widget.remoteRenderer.initialize();
    initializeMeet();
    super.initState();
  }

  void closeMeetDialog() {
    setState(() {
      showMeetDetails = false;
    });
  }

  void initializeMeet() async {
    print(widget.isNew);
    await meetHelper.openUserMedia(widget.localRenderer, widget.remoteRenderer);

    meetHelper.onAddRemoteStream = ((stream) {
      widget.remoteRenderer.srcObject = stream;
      setState(() {});
    });
    
    if(widget.isNew) {
      widget.meetKey = await meetHelper.newMeet(widget.remoteRenderer);
      setState(() {});
    } else {
      await meetHelper.joinMeet(widget.meetKey!, widget.remoteRenderer);
      setState(() {
        showMeetDetails = false;
      });
    }
  }

  @override
  void dispose() {
    widget.localRenderer.dispose();
    widget.remoteRenderer.dispose();
    super.dispose();
  }

  SizedBox videoRenderers() => SizedBox(
    height: MediaQuery.of(context).size.height,
    child: Flex(
      direction: Axis.vertical,
      children: [
        Flexible(
          child: RTCVideoView(widget.localRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover, mirror: true),
        ),
        Flexible(
          child: RTCVideoView(widget.remoteRenderer, objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          videoRenderers(),
          Positioned.fill(
            bottom: 50,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Tooltip(
                    message: 'Hangup',
                    preferBelow: false,
                    child: IconButton.filled(
                      onPressed: () async {
                        await meetHelper.hangUp(widget.localRenderer);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      }, 
                      icon: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),

          if(widget.meetKey != null && showMeetDetails) Positioned(
            bottom: 10,
            left: 10,
            child: MeetDetails(meetKey: widget.meetKey ?? 'err', onClose: closeMeetDialog)
          ),
        ],
      ),
    );
  }
}