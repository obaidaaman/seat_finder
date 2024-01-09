import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: const Text(
          'Seat View',
          style: TextStyle(
              fontFamily: "Poppins",
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 45.w),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showProgressIndicator = true;
                  });

                  Future.delayed(
                    const Duration(milliseconds: 500),
                    () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (context) => const SeatFinderPage()))
                          .then((_) {
                        setState(() {
                          _showProgressIndicator = false;
                        });
                      });
                    },
                  );
                },
                child:  Text(
                  "Seat Finder",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.italic),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (_showProgressIndicator) const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
