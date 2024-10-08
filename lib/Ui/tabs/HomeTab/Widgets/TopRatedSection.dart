
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Data/Response/TopRatedOrPopularResponse.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/movie_details_screen.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';
import 'package:movies_app/Ui/tabs/HomeTab/Widgets/topRatedItem.dart';



class TopRatedSection extends StatefulWidget {
  final String? name;
  final List<topRatedOrPopular> topRatedList; // Ensure proper class name

  TopRatedSection({required this.topRatedList, required this.name});

  @override
  State<TopRatedSection> createState() => _TopRatedSectionState();
}

class _TopRatedSectionState extends State<TopRatedSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            widget.name ?? 'Recomended',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: AppColors.whiteColorText),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          height: 200.h,

          //  width: 300.w, // Wrapping GridView in a SizedBox for height
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.topRatedList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder:(context)=>
                              MovieDetailsScreen(movieId:widget.topRatedList[index].id!.toInt())));
                },
                child: TopRatedItem(
                  // Assuming CardItem is a widget you've defined
                  topratedorpopular:
                  widget.topRatedList[index], // Pass correct data
                ),
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
          ),
        ),
      ],
    );
  }
}