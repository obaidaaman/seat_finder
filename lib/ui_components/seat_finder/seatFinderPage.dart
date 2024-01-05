import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seat_finder/constants/colors.dart';
import 'package:seat_finder/widget_components/side_widget.dart';

class SeatFinderPage extends StatefulWidget {
  const SeatFinderPage({super.key});

  @override
  State<SeatFinderPage> createState() => _SeatFinderPageState();
}

class _SeatFinderPageState extends State<SeatFinderPage> {
  String? searchText;

  bool contains = false;
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
        title: const Text(
          "Seat Finder",
          style: TextStyle(color: SFColors.matchedSeatColor, fontSize: 21),
        ),
        centerTitle: false,
        backgroundColor: SFColors.whiteColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Stack(
              children: [
                Expanded(
                  child: Padding(
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
                          });
                        },
                        child: const Text(
                          "Find",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
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
}
