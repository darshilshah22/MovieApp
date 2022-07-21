import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../Constants/Colors.dart';
import '../Constants/Constants.dart';
import '../apis/API_Services.dart';

class HorizontalListView extends StatefulWidget {
  final Function func;
  const HorizontalListView(this.func, {Key? key}) : super(key: key);

  @override
  _HorizontalListViewState createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {
  ApiCalls apiCalls = ApiCalls();
  var data;

  getMovies() async {
    data = await apiCalls
        .getData("https://api.themoviedb.org/3/movie/550?api_key=$movieAPIKey");
    setState(() {});
  }

  @override
  void initState() {
    getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 300,
      color: Colors.transparent,
      child: data != null
          ? ListView.builder(
              itemCount: 6,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    widget.func();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 200,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        margin: const EdgeInsets.only(right: 18),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image(
                                image: NetworkImage(
                                    "$imageURL${data['poster_path']}"),
                                fit: BoxFit.fill)),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        data['title'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: ColorConstants.blue,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Dec 15, 2021",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              })
          : const Center(
              child: CircularProgressIndicator(
              color: Colors.black,
            )),
    );
  }
}

class HorizontalPageView extends StatefulWidget {
  const HorizontalPageView({Key? key}) : super(key: key);

  @override
  _HorizontalPageViewState createState() => _HorizontalPageViewState();
}

class _HorizontalPageViewState extends State<HorizontalPageView> {
  PageController controller =
      PageController(viewportFraction: 0.8, keepPage: true);
  int _curr = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: PageView(
            controller: controller,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: List.generate(6, (index) {
              return Container(
                  height: 200,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/img6.jpg"),
                        fit: BoxFit.fill),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    color: Colors.black.withOpacity(0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.play_circle_fill,
                            size: 40, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Watch Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ));
            }),
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: controller,
          count: 6,
          effect: const ExpandingDotsEffect(
            dotHeight: 10,
            dotWidth: 10,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class HorizontalImages extends StatefulWidget {
  const HorizontalImages({Key? key}) : super(key: key);

  @override
  _HorizontalImagesState createState() => _HorizontalImagesState();
}

class _HorizontalImagesState extends State<HorizontalImages> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      height: 280,
      child: ListView.builder(
          itemCount: 6,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 270,
                  width: 270,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.only(right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6)),
                          child: Image(
                              image: AssetImage("assets/images/img1.jpg"),
                              fit: BoxFit.fill)),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: Row(
                          children: const [
                            Text(
                              "Movie Name",
                              style: TextStyle(
                                  color: ColorConstants.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Icon(Icons.star,
                                color: ColorConstants.blue, size: 30),
                            Text(
                              "4.5",
                              style: TextStyle(
                                  color: ColorConstants.blue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 10),
                        child: const Text(
                          "Genre",
                          style: TextStyle(
                              color: ColorConstants.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
