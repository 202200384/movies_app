import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Data/Response/BrowserResponse.dart';
import 'package:movies_app/Data/Response/BrowserDiscoveryResponse.dart';
import 'package:movies_app/Ui/Utils/my_assets.dart';

class BrowserItem extends StatelessWidget {
  final Browser? browser;
  final Results? discoveryMovie;

  BrowserItem({Key? key, this.browser, this.discoveryMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 150.h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: discoveryMovie != null && discoveryMovie?.posterPath != null
                  ? NetworkImage(_getImageForItem())
                  : AssetImage(_getImageForItem()) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Text(
            _getItemName(),
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0.r,
                  color: Colors.black.withOpacity(0.7),
                  offset: Offset(2, 2),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _getImageForItem() {
    if (discoveryMovie?.posterPath != null) {
      return 'https://image.tmdb.org/t/p/w500${discoveryMovie!.posterPath}';
    }

    switch (browser?.name?.toLowerCase()) {
      case 'comedy':
        return MyAssets.BestCommedies;
      case 'horror':
        return MyAssets.download4;
      case 'action':
        return MyAssets.download2;
      case 'animation':
        return MyAssets.download3;
      default:
        return MyAssets.download1;
    }
  }

  String _getItemName() {
    return discoveryMovie?.title ?? browser?.name ?? "Movie";
  }
}