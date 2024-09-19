import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Data/Response/TopRatedOrPopularResponse.dart';
import 'package:shared_preferences/shared_preferences.dart';


class popularitem extends StatefulWidget {
  final topRatedOrPopular? moviecard;
  popularitem({Key? key, required this.moviecard}) : super(key: key);

  @override
  State<popularitem> createState() => _popularitemState();
}

class _popularitemState extends State<popularitem> {
  bool _isFavorite =
  false; // To track if the icon image is in a "selected" state

  @override
  void initState() {
    super.initState();
    _loadIconState(); // Load the saved state when the widget is created
  }

  // Load the saved state of the icon image from SharedPreferences
  void _loadIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = prefs.getBool('isFavorite') ?? false;
    });
  }

  // Save the icon state to SharedPreferences
  void _saveIconState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite', _isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      //  alignment: Alignment.topRight, // Align the icon image to the top-right
      children: [
        // Display the main image (e.g., the background image)
        Container(
          margin: EdgeInsets.all(10),
          height: 140.h, // Set the image height
          width: 100.w, // Set the image width
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${widget.moviecard?.posterPath ?? ""}',
              ), // Main image path from the movie data
              fit: BoxFit.cover,
            ),
          ),
        ),
        // The tappable icon image overlaid on the main image
        Positioned(
          left: 20.w,
          top: 90.h,
          bottom: 200.h,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isFavorite = !_isFavorite; // Toggle the state
                _saveIconState(); // Save the state when tapped
              });
            },
            child: Image.asset(
              _isFavorite
                  ? 'assets/images/bookmark.png' // Selected state image
                  : 'assets/images/Icon awesome-bookmark.png', // Unselected state image
              width: 30.w, // Set the width of the icon image
              height: 40.h, // Set the height of the icon image
            ),
          ),
        ),
      ],
    );
  }
}