import 'package:cached_network_image/cached_network_image.dart';
import 'package:demotask/response/res_user.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/colors.dart';
import '../utils/dimens.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key, this.userList}) : super(key: key);
  final Results? userList;

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    tooltip: 'Navigation menu',
                    onPressed: () {
                      Navigator.pop(context);
                    }, // null disables the button
                  ),
                  Text(
                    '${widget.userList?.name?.first ?? ''} ${widget.userList?.name?.last ?? ''}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontMedium1,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: CachedNetworkImage(
                  height: 80,
                  imageUrl: widget.userList?.picture?.thumbnail ?? "",
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                color: Colors.pink,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Container(
                  margin: const EdgeInsets.all(spacingMedium1),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.sticky_note_2_rounded,
                            size: spacingMedium,
                            color: colorWhite,
                          ),
                          SizedBox(
                            width: spacingTiny,
                          ),
                          Text(
                            'Bio',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: colorWhite,
                                fontSize: fontMedium),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: spacingTiny,
                      ),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetyr adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magne aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco labroris nisi ut aliquip exeacom modo consequat.',
                        style: TextStyle(fontSize: 14, color: colorWhite),
                      ),
                      const SizedBox(
                        height: spacingMedium,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _makePhoneCall(
                                'tel:${widget.userList?.phone ?? ''}');
                          });
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.phone_in_talk,
                              color: colorWhite,
                              size: fontMedium,
                            ),
                            const SizedBox(
                              width: spacingTiny,
                            ),
                            Text(
                              '+ ' + (widget.userList?.phone ?? ''),
                              style: const TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontMedium),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: spacingMedium,
                      ),
                      InkWell(
                        onTap: () {
                          launch(
                              "mailto:${widget.userList?.email ?? ''}?Subject=hii&bodyHow are you%20plugin");
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.mail,
                              color: colorWhite,
                              size: fontMedium,
                            ),
                            const SizedBox(
                              width: spacingTiny,
                            ),
                            Text(
                              widget.userList?.email ?? '',
                              style: const TextStyle(
                                  color: colorWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontMedium),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
