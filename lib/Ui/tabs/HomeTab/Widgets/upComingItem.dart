
 // Import your upcoming data model here

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/Utils/my_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Data/Response/upComingResponse.dart';


class Upcomingitem extends StatefulWidget {
  final upComing? upcoming; // Declare the movie data (optional)
  Upcomingitem({Key? key, required this.upcoming})
      : super(key: key); // Pass the movie data to the widget

  @override
  State<Upcomingitem> createState() => _UpcomingitemState();
}

class _UpcomingitemState extends State<Upcomingitem> {
  bool _isFavorite = false; // To track if the movie is in a "favorite" state

  @override
  void initState() {
    super.initState();
    _loadIconState(); // Load the saved state when the widget is created
  }

  // Load the saved state of the icon image from SharedPreferences
  void _loadIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = prefs.getBool('isFavorite_${widget.upcoming?.id}') ?? false;
    });
  }

  // Save the icon state to SharedPreferences
  void _saveIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite_${widget.upcoming?.id}', _isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.upcoming; // Access movie data

    return Stack(
      children: [
        // Display the main image (e.g., the background image)
        Container(
          margin: EdgeInsets.all(10),
          height: 140.h, // Set the image height
          width: 100.w, // Set the image width
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${movie?.posterPath ?? ""}',
              ), // Main image path from the movie data
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(
                10), // Add a border radius for rounded edges
          ),
        ),
        // The tappable icon image overlaid on the main image
        Positioned(
          left: 10.w,
          top: 10.h,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isFavorite = !_isFavorite; // Toggle the favorite state
                _saveIconState(); // Save the state when tapped
              });
            },
            child: Image.asset(
              _isFavorite
                  ? MyAssets.addBookMark // Selected state image
                  : MyAssets.bookMark, // Unselected state image
              width: 30.w, // Set the width of the icon image
              height: 40.h, // Set the height of the icon image
            ),
          ),
        ),
        // Add movie title at the bottom
        Positioned(
          bottom: 10.h,
          left: 10.w,
          right: 10.w,
          child: Container(
            color: Colors.black.withOpacity(0.5),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: Text(
              movie?.title ?? 'Unknown', // Movie title from the data
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp, // Font size for title
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }
}