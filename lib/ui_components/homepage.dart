import 'package:flutter/material.dart';
import 'package:seat_finder/ui_components/seat_finder/seatFinderPage.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _SeatViewState();
}

class _SeatViewState extends State<HomePage> {

  bool _showProgressIndicator = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat View'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 45),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showProgressIndicator = true;
                  });

                 Future.delayed(Duration(seconds: 1),() {
                   Navigator.of(context).push(
                       MaterialPageRoute(builder: (context) => const SeatFinderPage())
                   ).then((_){
                     setState(() {
                       _showProgressIndicator = false;
                     });
                   });
                 },);

                },
                child: const Text(
                  "Seat Finder",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),

              if(_showProgressIndicator)
                const CircularProgressIndicator()

            ],
          ),
        ),
      ),
    );
  }
}

void cricleButton() {

}
