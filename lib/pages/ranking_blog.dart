import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/ranking_blog_component.dart';
import 'package:final_year_project/components/tab_bar.dart';
import 'package:flutter/material.dart';

class RankingBlog extends StatefulWidget {
  const RankingBlog({Key? key}) : super(key: key);

  @override
  _RankingBlogState createState() => _RankingBlogState();
}

class _RankingBlogState extends State<RankingBlog> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40, child: TopAppBar()),
                const TitleAppBar(
                    title: 'Ranking Blog',
                    iconFlex: 1,
                    titleFlex: 2,
                    hasArrow: true),
                SizedBox(
                    height: 550,
                    child: RatingMonthTabBar(
                      latestFirstMonth: 'MAY 2022',
                      latestSecondMonth: 'APRIL 2022',
                      latestThirdMonth: 'MARCH 2022',
                      latestFirstMonthBody: SingleChildScrollView(
                          child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return const RankingBlogComponent();
                          },
                        ),
                      )),
                      latestSecondMonthBody: SingleChildScrollView(
                          child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return const RankingBlogComponent();
                          },
                        ),
                      )),
                      latestThirdMonthBody: SingleChildScrollView(
                          child: SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return const RankingBlogComponent();
                          },
                        ),
                      )),
                    ))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
