import 'package:eventell/Utils/utility.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          pageSnapping: true,
          children: <Widget>[
            new OnBoardingScreen(
              title: StringWord.titleOnboard1,
              subtitle: StringWord.subtitleOnboard1,
              pageController: _pageController,
              page: 1,
            ),
            new OnBoardingScreen(
              title: StringWord.titleOnboard2,
              subtitle: StringWord.subtitleOnboard2,
              pageController: _pageController,
              page: 2,
            ),
            new OnBoardingScreen(
              title: StringWord.titleOnboard3,
              subtitle: StringWord.subtitleOnboard3,
              pageController: _pageController,
              page: 3,
            ),
          ],
        ));
  }
}

class OnBoardingScreen extends StatelessWidget {
  final String title, subtitle;
  final PageController pageController;
  final int page;

  const OnBoardingScreen(
      {Key key, this.title, this.subtitle, this.pageController, this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 450,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                    top: 0, child: Image.asset('assets/graphics/ellipse.png')),
                Positioned(
                    top: 100,
                    left: 30,
                    child: Image.asset('assets/graphics/calendar.png')),
                Positioned(
                    top: 100,
                    right: 30,
                    child: Image.asset('assets/graphics/tent.png')),
                Positioned(
                    top: 230,
                    right: 30,
                    child: Image.asset('assets/graphics/placeholder.png')),
                Positioned(
                    top: 230,
                    left: 30,
                    child: Image.asset(
                        'assets/graphics/credit-cards-payment.png')),
                Positioned(
                    top: 30,
                    left: 10,
                    right: 10,
                    height: 420,
                    child: Image.asset('assets/graphics/human1.png')),
                Positioned(
                  top: 30,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        page != 1
                            ? SizedBox(
                                height: 50,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    pageController.previousPage(
                                      curve: Curves.easeInOut,
                                      duration: Duration(
                                          milliseconds:
                                              Sizing.onBoardDurationTime),
                                    );
                                  },
                                ))
                            : SizedBox(height: 50),
                        GestureDetector(
                          child: SizedBox(
                            height: 30,
                            child: Text(
                              'Skip',
                              style: TextStyle(fontSize: 21),
                            ),
                          ),
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, '/authPage');
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(this.title,
                  style: TextStyle(
                      color: Coloring.textOnBoard,
                      fontWeight: FontWeight.bold,
                      fontSize: Sizing.onBoardTitleSize))),
          Center(
              child: Text(this.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Coloring.textOnBoard,
                      fontSize: Sizing.onBoardSubTitleSize))),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SizedBox(
              width: 120,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Coloring.colorMain,
                child: Text(
                  page != 3 ? 'NEXT' : 'GET STARTED',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (page != 3) {
                    pageController.nextPage(
                        curve: Curves.easeInOut,
                        duration:
                            Duration(milliseconds: Sizing.onBoardDurationTime));
                  } else {
                    Navigator.pushReplacementNamed(context, '/authPage');
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
