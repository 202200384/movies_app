
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';
import 'package:movies_app/Ui/tabs/HomeTab/Widgets/upComingItem.dart';

import '../../../../Data/Response/upComingResponse.dart';


class upComingSection extends StatefulWidget {
  final String? name;
  final List<upComing> upComingList; // Ensure proper class name

  upComingSection({required this.upComingList, required this.name});

  @override
  State<upComingSection> createState() => _upComingSectionState();
}

class _upComingSectionState extends State<upComingSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greySearchBarColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              widget.name ?? 'New Release',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.whiteColorText),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 150.h, // Wrapping GridView in a SizedBox for height
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.upComingList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Upcomingitem(
                    // Assuming CardItem is a widget you've defined
                    upcoming: widget.upComingList[index], // Pass correct data
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Single row, multiple columns
                mainAxisSpacing: 0, // No spacing between items horizontally
                crossAxisSpacing: 0, // No spacing between items vertically
              ),
            ),
          ),
        ],
      ),
    );
  }
}