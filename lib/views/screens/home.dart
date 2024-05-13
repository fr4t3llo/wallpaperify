import 'package:flutter/material.dart';
import 'package:wallpaperify/controller/api_service.dart';
import 'package:wallpaperify/model/model_category.dart';
import 'package:wallpaperify/model/models_photo.dart';
import 'package:wallpaperify/views/screens/image.dart';
import 'package:wallpaperify/views/widgets/myappbar.dart';
import 'package:wallpaperify/views/widgets/search.dart';
import 'package:wallpaperify/views/widgets/pageforit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<GetPhotos> trendingWallList;
  late List<CategoryModel> modlist;
  bool isLoading = true;

  detailsGet() async {
    modlist = Api.getCategoriesList();
    setState(() {
      modlist = modlist;
    });
  }

  getTrendingWallpapers() async {
    trendingWallList = await Api.getTrendingWallpapers();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    detailsGet();
    getTrendingWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(),
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.waveDots(
                color: const Color.fromARGB(255, 0, 0, 0),
                size: 50,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: CustomSearchBar()),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: modlist.length,
                          itemBuilder: ((context, index) => CatBlock(
                                categorySrcImg: modlist[index].catImgUrl,
                                nameCategory: modlist[index].catName,
                              ))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 700,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      },
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 400,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8,
                                  mainAxisSpacing: 8),
                          itemCount: trendingWallList.length,
                          itemBuilder: ((context, index) => GridTile(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FullImage(
                                                imgUrl: trendingWallList[index]
                                                    .imgSrc)));
                                  },
                                  child: Hero(
                                    tag: trendingWallList[index].imgSrc,
                                    child: Container(
                                      height: 800,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              110, 64, 169, 255),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                            height: 800,
                                            width: 50,
                                            fit: BoxFit.cover,
                                            trendingWallList[index].imgSrc),
                                      ),
                                    ),
                                  ),
                                ),
                              ))),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
