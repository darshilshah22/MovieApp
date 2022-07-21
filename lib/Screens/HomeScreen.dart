import 'package:flutter/material.dart';
import 'package:movie_app/Constants/Colors.dart';
import 'package:movie_app/Screens/MovieReview.dart';
import 'package:movie_app/Widgets/HorizListView.dart';
import 'package:movie_app/Widgets/TitleWidget.dart';

import '../Constants/Constants.dart';
import '../Constants/Strings.dart';
import '../apis/API_Services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiCalls apiCalls = ApiCalls();
  var data;
  int _selectedIndex = 0;

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu, color: ColorConstants.blue),
        title: const Text(Strings.hello, style: TextStyle(color: ColorConstants.blue)),
        titleSpacing: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset("assets/icons/search.png", height: 30, width: 30, color: ColorConstants.blue),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: _selectedIndex == 0 ? FittedBox(
              child: Container(
                padding: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/video.png", height: 20, width: 20, color: ColorConstants.blue),
                    const SizedBox(width: 6),
                    const Text(
                      "Movies",
                      style: TextStyle(
                          color: ColorConstants.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ) : Image.asset("assets/icons/video.png", height: 20, width: 20, color: ColorConstants.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 1 ? FittedBox(
              child: Container(
                padding: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/video.png", height: 20, width: 20, color: ColorConstants.blue),
                    SizedBox(width: 6),
                    const Text(
                      "Movies",
                      style: TextStyle(
                          color: ColorConstants.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ) : Image.asset("assets/icons/video.png", height: 20, width: 20, color: ColorConstants.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: _selectedIndex == 2 ? FittedBox(
              child: Container(
                padding: EdgeInsets.only(top: 6, bottom: 6, left: 12, right: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/icons/user.png", height: 20, width: 20, color: ColorConstants.blue),
                    SizedBox(width: 6),
                    const Text(
                      "Profile",
                      style: TextStyle(
                          color: ColorConstants.blue,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ) : Image.asset("assets/icons/user.png", height: 20, width: 20, color: ColorConstants.blue),
            label: '',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            TitleWidget(Strings.popular, (){}),
            SizedBox(height: 16),
            HorizontalListView((){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MovieReview()));
            }),
            SizedBox(height: 30),
            TitleWidget(Strings.playingInTheater, (){}),
            SizedBox(height: 16),
            HorizontalPageView(),
            SizedBox(height: 30),
            TitleWidget(Strings.trending, (){}),
            SizedBox(height: 16),
            HorizontalListView((){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MovieReview()));
            }),
            SizedBox(height: 30),
            TitleWidget(Strings.topRated, (){}),
            SizedBox(height: 16),
            HorizontalImages(),
            SizedBox(height: 30),
            TitleWidget(Strings.upcomming, (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const MovieReview()));
            }),
            SizedBox(height: 16),
            HorizontalListView((){}),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
