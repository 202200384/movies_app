


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/movie_details_screen.dart';
import 'package:movies_app/Ui/Utils/my_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Data/Response/TopRatedOrPopularResponse.dart';

class TopRatedItem extends StatefulWidget {
  final topRatedOrPopular?
  topratedorpopular; // Added 'final' here for immutability
  const TopRatedItem({Key? key, required this.topratedorpopular})
      : super(key: key); // Fixed constructor

  @override
  State<TopRatedItem> createState() => _TopRatedItemState();
}

class _TopRatedItemState extends State<TopRatedItem> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadIconState();
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
    prefs.setBool('isFavorite${widget.topratedorpopular?.id}', _isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.topratedorpopular;

    return GestureDetector(
      onTap: (){
        if(movie!=null){
          Navigator.push(context,
              MaterialPageRoute(
                  builder:(context)=>
                      MovieDetailsScreen(movieId: movie.id!.toInt())));
        }
      },
      child: Container(
        width: 100.w, // Adjusted container width for screen responsiveness
        height: 180.h, // Adjusted container height for screen responsiveness
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.5), // Black border with 50% opacity
            width: 2.0, // Border width
          ),
          borderRadius: BorderRadius.circular(5), // Optional: Add rounded corners
        ),
        child: Stack(
          children: [
            // Display the main image (e.g., the movie poster from network)
            Container(
              margin: EdgeInsets.all(10),
              height: 110.h, // Set the image height
              width: 90.w, // Set the image width
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${widget.topratedorpopular!.posterPath ?? ""}', // Fetch poster from API
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // The tappable icon image overlaid on the main image
            Positioned(
              left: 10.w,
              top: 10.h,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isFavorite = !_isFavorite; // Toggle the state
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

            // Rating, title, and additional info overlaid on the image
            Positioned(
              bottom: 0.h,
              left: 10.w,
              right: 10.w,
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating Row
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 18.w),
                        SizedBox(width: 4.w),
                        Text(
                          "${widget.topratedorpopular!.voteAverage ?? ""}", // Movie rating
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h), // Spacer between rows

                    // Title Row
                    Text(
                      '${widget.topratedorpopular!.title ?? ""}', // Movie title
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.h), // Spacer between rows

                    // Info Row (for release date, rating, etc.)
                    Text(
                      '${widget.topratedorpopular!.releaseDate ?? ""}  R  movieTime', // You can customize this with actual runtime data if available
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}