import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final itemController = ItemScrollController();

  final ItemPositionsListener _itemPositionsListener =
      ItemPositionsListener.create();

  bool contains = false;

  TextEditingController searchController = TextEditingController();

  void scrollToEnteredSeat() {
    if (searchText != null && searchText!.isNotEmpty) {
      int seatIndex = int.tryParse(searchText!) ?? -1;

      if (seatIndex != -1 && seatIndex >= 0 && seatIndex <= 80) {
        int scrollPosition = (seatIndex - 1) ~/ 10;

        itemController.scrollTo(
            index: scrollPosition,
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut);
      } else {
        invalidSeatSnackbar();
        print("Invalid Seat Number");
      }
    }
  }

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
        title: const Text(
          "Seat Finder",
          style: TextStyle(color: SFColors.matchedSeatColor, fontSize: 21),
        ),
        centerTitle: false,
        backgroundColor: SFColors.whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Stack(
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 5, right: 10),
                    child: TextFormField(
                      onChanged: onSearchTextChanged,
                      controller: searchController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Enter Seat Number...",
                        hintStyle: TextStyle(color: SFColors.matchedSeatColor),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                              width: 2, color: SFColors.matchedSeatColor),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(
                              width: 2, color: SFColors.matchedSeatColor),
                        ),
                      ),
                    ),
                  ),

                Positioned(
                  right: 2,
                  child: SizedBox(
                    width: 80,
                    height: 50,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (states) {
                              if (contains == false) {
                                return SFColors.disabledFindButton;
                              }
                              return SFColors.matchedSeatColor;
                            }),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)))),
                        onPressed: () {
                          setState(() {
                            searchText =
                                contains == true ? searchController.text : null;
                            searchController.clear();
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                            FocusScope.of(context).unfocus();
                            contains = false;
                            scrollToEnteredSeat();
                          });
                        },
                        child: const Text(
                          "Find",
                          style: TextStyle(
                              fontSize: 18, color: SFColors.whiteColor),
                        )),
                  ),
                ),
              ],
            ),
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

  void invalidSeatSnackbar() {
    final snackBar = SnackBar(
      content: Text("Invalid seat Entered, Try between 1-80"),
      duration: Duration(seconds: 3),
      backgroundColor: Colors.red,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
