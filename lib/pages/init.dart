import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {

  final int _daysSince = DateTime.now().difference(DateTime(2024,05,06)).inDays +1 ;
  int _totalGamesPlayed = 0;
  int _timeEarnedInSeconds = 0;
  final _gamesPlayedController = TextEditingController();
  final _hoursController = TextEditingController();
  final _minutesController = TextEditingController();
  final _secondsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshData();
  }

  void refreshData(){
    loadData();
    setState(() {});
  }

  void loadData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _timeEarnedInSeconds = pref.getInt("timeEarnedInSeconds") ?? 0;
    _totalGamesPlayed = pref.getInt("gamesPlayed") ?? 0;
  }

  void updateTotalGamesPlayed() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("gamesPlayed", int.parse(_gamesPlayedController.text));
    _gamesPlayedController.clear();
    refreshData();
  }

  void updateTotalTimeEarned() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    int hours = int.tryParse(_hoursController.text) ?? 0;
    int minutes = int.tryParse(_minutesController.text) ?? 0;
    int seconds = int.tryParse(_secondsController.text) ?? 0;
    int duration = Duration(hours: hours,minutes: minutes,seconds: seconds).inSeconds;
    pref.setInt("timeEarnedInSeconds", duration);
    pref.reload();
    _hoursController.clear();
    _minutesController.clear();
    _secondsController.clear();
    refreshData();
  }

  @override
  void dispose() {
    super.dispose();
    _gamesPlayedController.dispose();
    _hoursController.dispose();
    _minutesController.dispose();
    _secondsController.dispose();
  }

  final textStyle = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Days since start...........${_daysSince}",style: textStyle,),
          Text("Total games played.....${_totalGamesPlayed}",style: textStyle,),
          Text("Games remaining........${(_daysSince * 2) - _totalGamesPlayed}",style: textStyle,),
          Text("Total time earned........${Duration(seconds: _timeEarnedInSeconds).toString().split('.').first.padLeft(8, "0")}",style: textStyle,),
          const SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                  flex: 8,
                  child: TextField(
                    controller: _gamesPlayedController ,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Number of games played: ${_totalGamesPlayed.toString()}",
                      border: const OutlineInputBorder()
                    ),
                    textInputAction: TextInputAction.done,
                  )
              ),
              const Expanded(flex: 1,child: SizedBox()),
              Expanded(
                  flex: 1,
                  child: IconButton(onPressed: updateTotalGamesPlayed, icon: const Icon(Icons.check))
              ),
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _hoursController ,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "hh",
                        border: OutlineInputBorder()
                    ),
                    textInputAction: TextInputAction.next,
                  )
              ),
              const SizedBox(width: 10,),
              Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _minutesController ,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "mm",
                        border: OutlineInputBorder()
                    ),
                    textInputAction: TextInputAction.next,
                  )
              ),
              const SizedBox(width: 10,),
              Expanded(
                  flex: 2,
                  child: TextField(
                    controller: _secondsController ,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "ss",
                        border: OutlineInputBorder()
                    ),
                    textInputAction: TextInputAction.done,
                  )
              ),
              const Expanded(flex: 1,child: SizedBox()),
              Expanded(
                  flex: 1,
                  child: IconButton(onPressed: updateTotalTimeEarned, icon: const Icon(Icons.check))
              ),
            ],
          ),
        ],
      ),
    );
  }
}
