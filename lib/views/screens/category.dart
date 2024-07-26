import 'package:flutter/material.dart';
import 'package:wallpaperify/controller/api_service.dart';
import 'package:wallpaperify/model/models_photo.dart';
import 'package:wallpaperify/views/screens/image.dart';
import 'package:wallpaperify/views/widgets/myappbar.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatefulWidget {
  String name;
  String urlImg;

  CategoryScreen({super.key, required this.urlImg, required this.name});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  late List<GetPhotos> categoryResults;
  bool isLoading = true;
  getCatRelWall() async {
    categoryResults = await Api.searchWallpapers(widget.name);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getCatRelWall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(),
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.waveDots(
                color: const Color.fromARGB(255, 102, 99, 99),
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.network(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          widget.urlImg),
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black38,
                      ),
                      Positioned(
                        left: 120,
                        top: 40,
                        child: Column(
                          children: [
                            const Text("Category",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'my')),
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 45,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'my'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 700,
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 400,
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8),
                        itemCount: categoryResults.length,
                        itemBuilder: ((context, index) => GridTile(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FullImage(
                                              imgUrl: categoryResults[index]
                                                  .imgSrc)));
                                },
                                child: Hero(
                                  tag: categoryResults[index].imgSrc,
                                  child: Container(
                                    height: 800,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(109, 0, 65, 218),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                          height: 800,
                                          width: 50,
                                          fit: BoxFit.cover,
                                          categoryResults[index].imgSrc),
                                    ),
                                  ),
                                ),
                              ),
                            ))),
                  )
                ],
              ),
            ),
    );
  }
}
