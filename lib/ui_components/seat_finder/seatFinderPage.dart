import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:seat_finder/constants/colors.dart';

import '../../widget_components/cabin_widget.dart';

class SeatFinderPage extends StatefulWidget {
  const SeatFinderPage({super.key});

  @override
  State<SeatFinderPage> createState() => _SeatFinderPageState();
}

class _SeatFinderPageState extends State<SeatFinderPage> {
  String? searchText;
  bool contains = false;
  final itemController = ItemScrollController();

  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

  void onSearchTextChanged(String value) {
    setState(() {
      contains = value.isNotEmpty ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Seat Finder",
          style: TextStyle(
              fontFamily: "Poppins",
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w600,
              color: SFColors.matchedSeatColor,
              fontSize: 21.sp),
        ),
        centerTitle: false,
        backgroundColor: SFColors.whiteColor,
        actions: [
          IconButton(
              onPressed: () {
                searchController.clear();
                searchText = null;
              },
              icon: const Icon(Icons.clear))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 8.h,
            ),
            StackTextFormField(context),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ScrollablePositionedList.builder(
              itemScrollController: itemController,
              itemPositionsListener: _itemPositionsListener,
              itemBuilder: (context, index) {
                return Builder(
                    builder: (context) => CabinWidget(
                          index: index,
                          searchBarText: searchText,
                        ));
              },
              itemCount: 10,
            ))
          ],
        ),
      ),
    );
  }

  Stack StackTextFormField(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 5.w, right: 10.w, bottom: 5.w, top: 2.w),
          child: TextFormField(
            onChanged: onSearchTextChanged,
            controller: searchController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: "Enter Seat Number...",
              hintStyle: TextStyle(
                  color: SFColors.matchedSeatColor,
                  fontFamily: "Poppins",
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400),
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide:
                    BorderSide(width: 2, color: SFColors.matchedSeatColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide:
                    BorderSide(width: 2, color: SFColors.matchedSeatColor),
              ),
            ),
          ),
        ),
        Positioned(
          right: 2.w,
          bottom: 5.w,
          child: SizedBox(
            width: 70.w,
            height: 43.h,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith<Color>((states) {
                      if (contains == false) {
                        return SFColors.disabledFindButton;
                      }
                      return SFColors.matchedSeatColor;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)))),
                onPressed: () {
                  setState(() {
                    searchText =
                        contains == true ? searchController.text : null;
                    searchController.clear();
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    FocusScope.of(context).unfocus();
                    contains = false;
                    scrollToEnteredSeat();
                  });
                },
                child: const Text(
                  "Find",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: SFColors.whiteColor),
                )),
          ),
        ),
      ],
    );
  }

  void invalidSeatSnackbar() {
    const snackBar = SnackBar(
      content: Text("Invalid seat Entered, Try between 1-80"),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void scrollToEnteredSeat() {
    if (searchText != null && searchText!.isNotEmpty) {
      int seatIndex = int.tryParse(searchText!) ?? -1;

      if (seatIndex != -1 && seatIndex >= 0 && seatIndex <= 80) {
        int scrollPosition = (seatIndex - 1) ~/ 10;

        itemController.scrollTo(
            index: scrollPosition,
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut);
      } else {
        invalidSeatSnackbar();
        print("Invalid Seat Number");
      }
    }
  }
}
