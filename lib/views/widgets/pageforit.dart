import 'package:flutter/material.dart';
import 'package:wallpaperify/views/screens/category.dart';

// ignore: must_be_immutable
class CatBlock extends StatelessWidget {
  String nameCategory;
  String categorySrcImg;
  CatBlock(
      {super.key, required this.categorySrcImg, required this.nameCategory});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                    urlImg: categorySrcImg, name: nameCategory)));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 7),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  height: 50, width: 100, fit: BoxFit.cover, categorySrcImg),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12)),
            ),
            Positioned(
                left: 30,
                top: 15,
                child: Text(
                  nameCategory,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'my',
                      fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
