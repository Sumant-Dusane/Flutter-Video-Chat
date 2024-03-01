import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeetDetails extends StatelessWidget {
  final String meetKey;
  final VoidCallback onClose;


  MeetDetails({
    super.key,
    required this.onClose,
    required this.meetKey
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 250.0,
        height: 200.0,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: onClose,
                  icon: const Icon(Icons.close)
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('You Meeting is Ready'),
                TextFormField(
                  initialValue: meetKey,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: (){
                        Clipboard.setData(ClipboardData(text: meetKey))
                        .then((value) => 
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Copied to Clipboard')
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.copy),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}