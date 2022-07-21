import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/Constants/Colors.dart';
import 'package:movie_app/Screens/HomeScreen.dart';
import 'package:movie_app/Widgets/HorizListView.dart';
import 'package:movie_app/Widgets/TitleWidget.dart';

import '../Constants/Constants.dart';
import '../Constants/Strings.dart';
import '../apis/API_Services.dart';

class MovieReview extends StatefulWidget {
  const MovieReview({Key? key}) : super(key: key);

  @override
  _MovieReviewState createState() => _MovieReviewState();
}

class _MovieReviewState extends State<MovieReview> {
  ApiCalls apiCalls = ApiCalls();
  var data;

  getMovies()async{
    data = await apiCalls.getData("https://api.themoviedb.org/3/movie/550?api_key=$movieAPIKey");
    setState(() {});
  }

  @override
  void initState() {
    getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: data!=null ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(),
              Container(
                margin: const EdgeInsets.only(top: 16, left: 20),
                child: Text(
                  data['original_title'],
                  style: const TextStyle(
                      color: ColorConstants.blue,
                      fontSize: 26,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      _buildTags("Action"),
                      _buildTags("Adventure"),
                      _buildTags("Fictional"),
                    ],
                  ),
                ),
              ),
              _buildPreview(),
              _buildNowStreaming(),
              _buildOverView(),
              const SizedBox(height: 20),
              TitleWidget("Cast & Crew", (){

              }),
              const SizedBox(height: 20),
              _buildCastCrew(),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: ColorConstants.blue.withOpacity(0.1),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                ),
                padding: EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Collection",
                        style: TextStyle(
                            color: ColorConstants.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    _buildCollection(),
                    const SizedBox(height: 20),
                    Divider(
                      height: 0,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Information",
                        style: TextStyle(
                            color: ColorConstants.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    _buildInformation(),
                    const SizedBox(height: 20),
                    Divider(
                      height: 0,
                      color: Colors.grey.withOpacity(0.6),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: const Text(
                        "Videos",
                        style: TextStyle(
                            color: ColorConstants.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const HorizontalPageView(),
                    const SizedBox(height: 20),
                    Container(
                      color: Colors.blue,
                      padding: EdgeInsets.zero,
                      child: Divider(
                        height: 0,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TitleWidget("Recommended", (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
                    }),
                    const SizedBox(height: 20),
                    HorizontalListView((){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const MovieReview()));
                    })
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ) : const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 40, top: 20),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
              child: const Icon(Icons.arrow_back, color: ColorConstants.blue, size: 30)),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset("assets/icons/star.png",
                color: ColorConstants.blue),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset("assets/icons/love.png",
                color: ColorConstants.blue),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset("assets/icons/save.png",
                color: ColorConstants.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildTags(String name) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 14, top: 8, bottom: 8),
      margin: const EdgeInsets.only(right: 10, top: 16),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
              color: ColorConstants.blue,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
        height: 200,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          image: DecorationImage(
              image: NetworkImage("$imageURL${data['poster_path']}"), fit: BoxFit.fill),
        ),
        clipBehavior: Clip.hardEdge,
        child: Container(
          color: Colors.black.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.play_circle_fill, size: 40, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "Watch Trailer",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ));
  }

  Widget _buildNowStreaming(){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.blueAccent.withOpacity(0.1),
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Hotstar",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            "Now Streaming",
            style: TextStyle(
                color: ColorConstants.blue,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios_sharp, color: ColorConstants.blue, size: 30),
        ],
      ),
    );
  }

  Widget _buildOverView(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 26),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                Strings.overview,
                style: TextStyle(
                    color: ColorConstants.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
              const Spacer(),
              const Icon(Icons.star, color: ColorConstants.blue, size: 30),
              Text(
                data['vote_average'].toString(),
                style: const TextStyle(
                    color: ColorConstants.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            data['overview'],
            style: const TextStyle(
                color: ColorConstants.blue,
                fontSize: 18,
                fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCastCrew(){
    return SizedBox(
      height: 200,
      child: ListView.builder(
        itemCount: 4,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index){
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.only(left: 12, right: 12, top: 20),
          margin: EdgeInsets.only(right: 10, left: 20),
          child: Column(
            children: [
              const CircleAvatar(
                  radius: 30,
                 backgroundImage: AssetImage("assets/images/img2.jpg")),
              SizedBox(height: 8),
              const Text(
                "Tom Holand",
                style: TextStyle(
                    color: ColorConstants.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 8),
              Text(
                "Patel Parker/ \nSpiderman",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildCollection(){
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: const [
          Image(image: AssetImage("assets/images/img2.jpg"), height: 50, width: 50),
          SizedBox(width: 10),
          Text(
            "Spider-Man (Avengers)\nCollection",
            style: TextStyle(
                color: ColorConstants.blue,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          Spacer(),
          Icon(Icons.arrow_forward_ios_sharp, color: ColorConstants.blue, size: 20),
        ],
      ),
    );
  }

  Widget _buildInformation(){
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Status",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    data['status'],
                    style: TextStyle(
                        color: ColorConstants.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(width: 90),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Original Language",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    data['original_language'] == "en" ? "English" : "",
                    style: const TextStyle(
                        color: ColorConstants.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Budget",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '\$${data['budget']}',
                    style: const TextStyle(
                        color: ColorConstants.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(width: 70),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Revenue",
                    style: TextStyle(
                        color: Colors.grey.withOpacity(0.8),
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Text(
                    '\$${data['revenue']}',
                    style: const TextStyle(
                        color: ColorConstants.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
