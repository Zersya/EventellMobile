import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';
import '../utility.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Sizing.paddingContent,
                        right: Sizing.paddingContent),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Coloring.colorMain,
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(Sizing.paddingInfoTitle),
                        child: Text(StringWord.infoTitle,
                            style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 150,
                    child: PageView.builder(
                      itemCount: 5,
                      pageSnapping: true,
                      controller:
                          PageController(viewportFraction: 0.7, initialPage: 5),
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  Sizing.borderRadiusCard)),
                          color: Coloring.colorMain,
                          elevation: 8,
                          child: Padding(
                            padding:
                                const EdgeInsets.all(Sizing.paddingPageView),
                            child:
                                Container(child: Center(child: Text('<3 you'))),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: Sizing.paddingContent, right: Sizing.paddingContent),
                child: ListView.separated(
                  itemCount: 12,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 150,
                      child: Card(
                        elevation: 8,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('Hallo ' + index.toString())
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    if ((index % 3) == 0 && index != 0)
                      return SizedBox(
                        height: 50,
                        child: Card(
                          color: Colors.redAccent,
                          elevation: 8,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Iklan ' + index.toString())
                              ],
                            ),
                          ),
                        ),
                      );
                    else
                      return SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
