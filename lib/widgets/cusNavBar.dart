// import 'package:flutter/material.dart';

// class CustomNavBar extends StatefulWidget {
//   final int index;
//   const CustomNavBar({Key? key, required this.index}) : super(key: key);

//   @override
//   _CustomNavBarState createState() => _CustomNavBarState();
// }

// class _CustomNavBarState extends State<CustomNavBar> {
//   int selectedIndex = 0;
  

// @override
// void initState()
// {
//   super.initState();
//   setState(() {
//     selectedIndex =widget.index;
//   });
  
// }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 65,
//       padding: EdgeInsets.symmetric(horizontal: 20),
//       decoration: BoxDecoration(
//         color: Color(0xFF292B37),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           buildNavItem(Icons.home, '/homePage',0),
//           buildNavItem(Icons.category, '/category',1),
//           buildNavItem(Icons.favorite_border, '/favouritePage',2),
//           buildNavItem(Icons.list, '/watchListPage',3),
//         ],
//       ),
//     );
//   }

//   Widget buildNavItem(IconData icon, String route,int index ) {
//     return InkWell(
//       onTap: () {
//         setState(() {
//           selectedIndex = index;
//         });
//         Navigator.pushNamed(context, route);
//       },
//       child: Icon(
//         icon,
//         color: selectedIndex == index ? Colors.red : Colors.white,
//         size: 35,
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

import '../category.dart';
import '../favourite.dart';
import '../homePage.dart';
import '../watchlist.dart';



class NavPageView extends StatefulWidget {
  const NavPageView({super.key});

  @override
  NavPageViewState createState() => NavPageViewState();
}

class NavPageViewState extends State<NavPageView> {
  int selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    const homePage(),
    const categoryPage(),
    const favouritePage(),
    const watchListPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        // index: selectedIndex,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: Theme(
         data: ThemeData(
       canvasColor: const Color(0xFF292B37),
        ),

        child: BottomNavigationBar(
          //  backgroundColor: const Color(0xFF292B37),
          items: const [
            BottomNavigationBarItem(
                label: "", icon: Icon(Icons.home, size: 40.0)),
            BottomNavigationBarItem(
                label: "", icon: Icon(Icons.category, size: 40.0)),
            BottomNavigationBarItem(
                label: "", icon: Icon(Icons.favorite_border, size: 40.0)),
            BottomNavigationBarItem(
                label: "", icon: Icon(Icons.list, size: 40.0))
          ],
          currentIndex: selectedIndex,
          onTap: (index) {
            _pageController.jumpToPage(index);
            // setState(() {
            //   selectedIndex = index;
            // });
          },
         
          selectedItemColor: Colors.red,
          unselectedItemColor:Colors.white,
          selectedFontSize: 0.0, // adjust as desired
          unselectedFontSize: 0.0, // adjust as desired
        ),
      ),
    );
  }
}