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
      appBar: AppBar(
        title: Center(child: Text("Dayliho")),
        automaticallyImplyLeading: false, // Remove the back arrow
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          _pageController.jumpToPage(index);
        },
        indicatorColor: Color.fromARGB(255, 255, 168, 53),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Badge(label: Text('3'), child: Icon(Icons.sports)),
            label: 'Séances',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_online),
            label: 'Réservations',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.account_box_sharp),
            ),
            label: 'Compte',
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
          Seances(),
          Reservations(
            connectedUserData: widget.connectedUserData,
          ),
          Compte(connectedUserData: widget.connectedUserData),
        ],
      ),
    );
  }
}
