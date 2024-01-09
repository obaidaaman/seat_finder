import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seat_finder/constants/colors.dart';

class OppositeSeatWidget extends StatefulWidget {
  const OppositeSeatWidget(
      {super.key,
        required this.seatIndex,
        required this.seatType,
        this.searchBarText});

  final int seatIndex;
  final String seatType;

  final String? searchBarText;

  @override
  State<OppositeSeatWidget> createState() => _OppositeSeatWidgetState();
}

class _OppositeSeatWidgetState extends State<OppositeSeatWidget> {

  bool flag = false;

  bool _isTapped = false;
  bool shouldHighlightSeat() {


    print(
        'Search Text: ${widget.searchBarText}, Seat Index: ${widget.seatIndex.toString()}');

    bool isSeatIndexMatched = widget.searchBarText == widget.seatIndex.toString();
    return isSeatIndexMatched || _isTapped;
  }

  void _handleTap(){
    setState(() {

      _isTapped= !_isTapped;
    });
  }








  @override
  Widget build(BuildContext context) {
    bool shouldHighlight = shouldHighlightSeat();
    return GestureDetector(
      onTap: _handleTap ,

      child: Container(
        height: 50.h,
        width: 60.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: shouldHighlight
                      ? SFColors.blueColor.withOpacity(0.5)
                      : Colors.transparent,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1))
            ],
            border: Border.all(
              color:
              shouldHighlight  ? const Color(0xff126DCA) : Colors.transparent,
              width: 2,
            ),
            color: shouldHighlight  ? SFColors.matchedSeatColor :
            SFColors.unmatchedSeatColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.seatType,
              style: TextStyle(
                fontSize: 12.sp,
                color: shouldHighlight  ? SFColors.unmatchedSeatColor :
                SFColors.matchedSeatColor,
                fontWeight: FontWeight.normal,
              ),
            ),
             SizedBox(height: 6.h),
            Text(
              widget.seatIndex.toString(),
              style: TextStyle(
                fontSize: 16.sp,
                color:
                shouldHighlight  ? SFColors.unmatchedSeatColor:
                SFColors.matchedSeatColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),

          ],
        ),
      ),
    );
  }
}
