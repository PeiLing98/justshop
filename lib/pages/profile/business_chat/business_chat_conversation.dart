import 'package:final_year_project/components/loading.dart';
import 'package:final_year_project/constant.dart';
import 'package:final_year_project/models/chat_model.dart';
import 'package:final_year_project/models/user_model.dart';
import 'package:final_year_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BusinessChatConversation extends StatefulWidget {
  final Chat chat;
  final AllUser user;
  const BusinessChatConversation(
      {Key? key, required this.chat, required this.user})
      : super(key: key);

  @override
  _BusinessChatConversationState createState() =>
      _BusinessChatConversationState();
}

class _BusinessChatConversationState extends State<BusinessChatConversation> {
  TextEditingController controller = TextEditingController();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    List conversation = [
      {
        "sendBy": widget.chat.user2,
        "message": controller.text.toString(),
        "time": dateFormat.format(DateTime.now())
      }
    ];

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 30,
          backgroundColor: secondaryColor,
          title: Row(
            children: [
              Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color.fromARGB(250, 233, 221, 221),
                    border: Border.all(color: Colors.grey)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: const Icon(
                      Icons.person_rounded,
                      size: 20,
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.user.username,
                style: boldContentTitle,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: StreamBuilder<UserStoreData>(
              stream: DatabaseService(uid: user?.uid).userStoreData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  UserStoreData? store = snapshot.data;

                  return StreamBuilder<List<Chat>>(
                      stream: DatabaseService(uid: "").chat,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Chat>? chat = snapshot.data;
                          List<Chat>? matchedChat = [];

                          matchedChat = chat?.where((chat) {
                            return chat.user1 == widget.user.userId &&
                                chat.user2 == store?.storeId;
                          }).toList();

                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 80,
                            child: Column(children: [
                              Expanded(
                                flex: 9,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 15),
                                    child: matchedChat!.isEmpty
                                        ? const Center(
                                            child: Text(
                                              'Start Your Conversation Now...',
                                              style: ratingLabelStyle,
                                            ),
                                          )
                                        : ListView.builder(
                                            itemCount:
                                                matchedChat[0].message.length,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                mainAxisAlignment: matchedChat?[
                                                                    0]
                                                                .message[index]
                                                            ['sendBy'] ==
                                                        widget.chat.user1
                                                    ? MainAxisAlignment.end
                                                    : MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        if (matchedChat?[0]
                                                                        .message[
                                                                    index]
                                                                ['sendBy'] ==
                                                            widget.chat.user2)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 5),
                                                            child: Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      250,
                                                                      233,
                                                                      221,
                                                                      221),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey)),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                child: Image.network(
                                                                    store!
                                                                        .imagePath,
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                          ),
                                                        Column(
                                                          crossAxisAlignment: matchedChat?[0]
                                                                              .message[
                                                                          index]
                                                                      [
                                                                      'sendBy'] ==
                                                                  widget.chat
                                                                      .user1
                                                              ? CrossAxisAlignment
                                                                  .end
                                                              : CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              constraints:
                                                                  const BoxConstraints(
                                                                      maxWidth:
                                                                          300),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color:
                                                                      secondaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  border: Border
                                                                      .all(
                                                                          color:
                                                                              secondaryColor)),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(10),
                                                                  child: Text(
                                                                    matchedChat?[0]
                                                                            .message[index]
                                                                        [
                                                                        'message'],
                                                                    style:
                                                                        filterTitleFontStyle,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .visible,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              matchedChat?[0]
                                                                      .message[
                                                                  index]['time'],
                                                              style:
                                                                  listingDescription,
                                                            )
                                                          ],
                                                        ),
                                                        if (matchedChat?[0]
                                                                        .message[
                                                                    index]
                                                                ['sendBy'] ==
                                                            widget.chat.user1)
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Container(
                                                              width: 20,
                                                              height: 20,
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: const Color
                                                                          .fromARGB(
                                                                      250,
                                                                      233,
                                                                      221,
                                                                      221),
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .grey)),
                                                              child: ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .person_rounded,
                                                                    size: 10,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                            ),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            })),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            blurRadius: 8,
                                            color: Colors.grey,
                                            offset: Offset(2, 2))
                                      ],
                                      borderRadius: BorderRadius.zero),
                                  child: ClipRRect(
                                      child: Container(
                                    height: 50,
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 9,
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15, vertical: 5),
                                            child: TextField(
                                              controller: controller,
                                              style: ratingLabelStyle,
                                              decoration: const InputDecoration(
                                                  hintText: 'Type a message...',
                                                  hintStyle: listingDescription,
                                                  border: InputBorder.none,
                                                  isCollapsed: true),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: IconButton(
                                              padding: const EdgeInsets.all(0),
                                              alignment: Alignment.centerRight,
                                              icon: const Icon(
                                                Icons.send,
                                                size: 20,
                                              ),
                                              onPressed: () async {
                                                if (widget.chat.chatId == "") {
                                                  if (matchedChat!.isEmpty) {
                                                    await DatabaseService(
                                                            uid: user?.uid)
                                                        .createChatRoom(
                                                            widget.chat.user1,
                                                            store!.storeId,
                                                            conversation);
                                                    controller.clear();
                                                  } else {
                                                    await DatabaseService(
                                                            uid: user?.uid)
                                                        .updateMessage(
                                                            matchedChat[0]
                                                                .chatId,
                                                            conversation);
                                                    controller.clear();
                                                  }
                                                } else {
                                                  await DatabaseService(
                                                          uid: user?.uid)
                                                      .updateMessage(
                                                          widget.chat.chatId,
                                                          conversation);
                                                  controller.clear();
                                                }
                                              },
                                            ))
                                      ],
                                    ),
                                  )),
                                ),
                              ),
                            ]),
                          );
                        } else {
                          return const Loading();
                        }
                      });
                } else {
                  return Loading();
                }
              }),
        ),
      ),
    );
  }
}
