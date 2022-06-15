import 'package:final_year_project/components/app_bar.dart';
import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/chat_model.dart';
import 'package:final_year_project/models/store_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/pages/profile/user_chat/user_chat_conversation.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserChat extends StatefulWidget {
  const UserChat({Key? key}) : super(key: key);

  @override
  _UserChatState createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  String chatSearch = "";

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: StreamBuilder<List<Chat>>(
          stream: DatabaseService(uid: "").chat,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Chat>? chat = snapshot.data;
              List<Chat>? matchedChat = [];

              matchedChat = chat?.where((chat) {
                return chat.user1 == user?.uid;
              }).toList();

              return StreamBuilder<List<Store>>(
                  stream: DatabaseService(uid: "").stores,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Store>? store = snapshot.data;
                      List<Store>? matchedStore = [];

                      for (int i = 0; i < matchedChat!.length; i++) {
                        for (int j = 0; j < store!.length; j++) {
                          if (matchedChat[i].user2 == store[j].storeId) {
                            matchedStore.add(store[j]);
                          }
                        }
                      }

                      return Scaffold(
                        body: SafeArea(
                          child: Column(
                            children: [
                              const SizedBox(height: 40, child: TopAppBar()),
                              Expanded(
                                flex: 1,
                                child: TitleAppBar(
                                  title: "Chat",
                                  iconFlex: 4,
                                  titleFlex: 5,
                                  hasArrow: true,
                                  onClick: () {
                                    Navigator.pushNamed(context, '/profile');
                                  },
                                ),
                              ),
                              Expanded(
                                  flex: 12,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Row(
                                          //   children: [
                                          //     Expanded(
                                          //       flex: 9,
                                          //       child: Container(
                                          //         height: 35,
                                          //         decoration: BoxDecoration(
                                          //           borderRadius:
                                          //               BorderRadius.circular(
                                          //                   10),
                                          //           border: Border.all(
                                          //               color: Colors.grey),
                                          //         ),
                                          //         padding: const EdgeInsets
                                          //                 .symmetric(
                                          //             horizontal: 15,
                                          //             vertical: 10),
                                          //         child: TextField(
                                          //           style: ratingLabelStyle,
                                          //           decoration:
                                          //               const InputDecoration(
                                          //                   hintText:
                                          //                       'Search store name here...',
                                          //                   hintStyle:
                                          //                       ratingLabelStyle,
                                          //                   border: InputBorder
                                          //                       .none,
                                          //                   isCollapsed: true),
                                          //           onChanged: (val) {
                                          //             setState(() {
                                          //               chatSearch = val;
                                          //             });
                                          //           },
                                          //         ),
                                          //       ),
                                          //     ),
                                          //     Expanded(
                                          //         flex: 1,
                                          //         child: IconButton(
                                          //             onPressed: () {},
                                          //             padding:
                                          //                 const EdgeInsets.all(
                                          //                     0),
                                          //             alignment:
                                          //                 Alignment.centerRight,
                                          //             icon: const Icon(
                                          //               Icons.search_rounded,
                                          //               size: 20,
                                          //             )))
                                          //   ],
                                          // ),
                                          SizedBox(
                                            height: 550,
                                            child: matchedChat.isEmpty
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const [
                                                      Text(
                                                        'No chat currently',
                                                        style: ratingLabelStyle,
                                                      ),
                                                    ],
                                                  )
                                                : ListView.builder(
                                                    itemCount:
                                                        matchedChat.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Card(
                                                        elevation: 3,
                                                        child: InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            UserChatConversation(
                                                                              chat: matchedChat![index],
                                                                              store: matchedStore[index],
                                                                            )));
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            child: ListTile(
                                                              title: Text(
                                                                matchedStore[
                                                                        index]
                                                                    .businessName,
                                                                style:
                                                                    boldContentTitle,
                                                              ),
                                                              subtitle: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 5),
                                                                child: Text(
                                                                  matchedChat![
                                                                          index]
                                                                      .message
                                                                      .last['message'],
                                                                  style:
                                                                      ratingLabelStyle,
                                                                ),
                                                              ),
                                                              leading:
                                                                  Container(
                                                                width: 50,
                                                                height: 50,
                                                                decoration: BoxDecoration(
                                                                    color: const Color
                                                                            .fromARGB(
                                                                        250,
                                                                        233,
                                                                        221,
                                                                        221),
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .grey)),
                                                                child: ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    child: Image.network(
                                                                        matchedStore[index]
                                                                            .imagePath,
                                                                        fit: BoxFit
                                                                            .cover)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const Loading();
                    }
                  });
            } else {
              return const Loading();
            }
          }),
    );
  }
}
