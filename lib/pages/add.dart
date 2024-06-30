import 'package:flutter/material.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final int _daysSince = DateTime.now().difference(DateTime(2024,05,06)).inDays +1 ;
  int _gamesPlayed = 0;
  int _timeEarnedInSeconds = 0;
  Duration _timeEarned = Duration(seconds: 0 );
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Days since 05 May 2024:  ${_daysSince}"),
            Text("Total required games:    ${2*_daysSince}"),
            Text("Total games played:      ${_gamesPlayed}"),
            Text("Total time earned:       ${_timeEarned.toString().split('.').first.padLeft(8, "0")}"),
            const SizedBox(width: 100,),
            TextField(
              autofocus: true,
              controller: _controller,
              maxLength: 5,
              keyboardType: const TextInputType.numberWithOptions(decimal: false,signed: false),
              onChanged: (value){
                // if(_controller.text.length==2){
                //   _controller.text = "${_controller.text}:";
                // }
              },
              decoration: InputDecoration(
                hintText: "Enter time (hh:mm:ss)",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: (){
                    _controller.clear();
                  },
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
