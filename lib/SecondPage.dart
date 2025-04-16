import 'package:flutter/material.dart';
import 'Accueil.dart';
import 'Seances.dart';
import 'Compte.dart';
import 'Reservations.dart';

/* Page entière */
class SecondPage extends StatefulWidget {
  final String email;
  final Map<String, dynamic> connectedUserData;
  const SecondPage(
      {super.key, required this.email, required this.connectedUserData});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  void navigateToSeances() {
    _pageController.jumpToPage(1);
  }

  void navigateToMySeances() {
    _pageController.jumpToPage(2);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white

      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          _pageController.jumpToPage(index);
        },
        indicatorColor: Color.fromARGB(255, 255, 168, 53),
        selectedIndex: currentPageIndex,
        labelBehavior: NavigationDestinationLabelBehavior
            .alwaysShow, // Ensure labels are always shown
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          NavigationDestination(
            icon: Badge(label: Text('!'), child: Icon(Icons.sports)),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark_border),
            label: '',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_box_sharp),
            label: '',
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        children: [
          Accueil(
            connectedUserData: widget.connectedUserData,
            onSeanceSelected: navigateToSeances,
            onCompteSelected: navigateToMySeances,
          ),
          Seances(
              userId: widget.connectedUserData['userId']
                  .toString()), // Pass userId to Seances
          Reservations(
            connectedUserData: widget.connectedUserData,
          ),
          Compte(connectedUserData: widget.connectedUserData),
        ],
      ),
    );
  }
}
