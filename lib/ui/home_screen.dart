import 'package:cached_network_image/cached_network_image.dart';
import 'package:demotask/response/res_user.dart';
import 'package:demotask/ui/user_details_page.dart';
import 'package:demotask/utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../api/api_constant.dart';
import '../api/api_service.dart';
import '../utils/colors.dart';
import '../utils/dimens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Results> userList = [];

  bool isLoading = false;
  bool isLoadingPage = false;

  int page = 0;
  bool stop = false;

  @override
  void initState() {
    super.initState();
    getProvidersOffers(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Center(
            child: Text(
          'Bookings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        )),
        backgroundColor: Colors.white54,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: spacingMedium,
          ),
          Flexible(
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return (userList.length - 1) == index
                    ? VisibilityDetector(
                        key: Key(index.toString()),
                        child: itemView(index),
                        onVisibilityChanged: (val) {
                          if (!stop && index == userList.length - 1) {
                            getProvidersOffers(false);
                          }
                        },
                      )
                    : itemView(index);
              },
            ),
          ),
          if (isLoadingPage) ...[
            const SizedBox(height: spacingTiny1),
            Utility.progress(context),
            const SizedBox(height: spacingMedium1),
          ]
        ],
      ),
    );
  }

  itemView(int index) {
    return SizedBox(
      height: 130,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: spacingMedium),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(spacingTiny1),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: spacingLarge,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: CachedNetworkImage(
                      height: spacingLarge1,
                      imageUrl: userList[index].picture?.thumbnail ?? "",
                      fit: BoxFit.fill,
                      width: spacingLarge1,
                    ),
                  ),
                ),
                const SizedBox(
                  width: spacingTiny,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            ('${userList[index].name?.first ?? ''}  ${userList[index].name?.last ?? ''}'),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: spacingTiny,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: fontSmall1,
                            color: Colors.black54,
                          ),
                          const SizedBox(
                            width: spacingTiny,
                          ),
                          Text(
                            getDateItem(index),
                            style: const TextStyle(fontSize: fontSmall),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: spacingTiny,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on_rounded,
                            size: fontSmall1,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: spacingTiny,
                          ),
                          Text(
                            'Yoga',
                            style: TextStyle(fontSize: fontSmall),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: spacingTiny,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2.0),
                            child: Icon(
                              Icons.location_on_rounded,
                              size: fontSmall1,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(
                            width: spacingTiny,
                          ),
                          Flexible(
                            child: Text(
                              '${userList[index].location?.street?.number ?? ''}, ${userList[index].location?.street?.name ?? ''}, ${userList[index].location?.city ?? ''}, ${userList[index].location?.state ?? ''},  ${userList[index].location?.country ?? ''}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: fontSmall),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.14,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(100))),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: colorWhite),
                            )),
                        onTap: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserDetailsPage(userList: userList[index])),
                          );
                        }),
                    const SizedBox(
                      height: spacingTiny,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.watch_later_outlined,
                          size: fontSmall1,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: spacingTiny,
                        ),
                        Text(
                          getTime(index),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spacingTiny,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.timer,
                          size: fontSmall1,
                          color: Colors.black54,
                        ),
                        SizedBox(
                          width: spacingTiny,
                        ),
                        Text("\$ 49"),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  getProvidersOffers(bool isFirst) async {
    if (await ApiManager.checkInternet()) {
      if (isFirst == true) {
        _changeLoadingState(true, isFirst);
      } else {
        _changePageLoadingState(true, isFirst);
      }
      var request = <String, dynamic>{};

      page = page + 1;
      request['page'] = page.toString();
      if (mounted) {
        UserResponse userResponse = UserResponse.fromJson(
          await ApiManager(context).getCall(
            AppStrings.apiBookingList(page, 10),
            request,
          ),
        );
        userList.addAll(userResponse.results!);
      }
      if (isFirst == true) {
        _changeLoadingState(false, isFirst);
      } else {
        _changePageLoadingState(false, isFirst);
      }
    } else {
      Utility.showToast(msg: 'No Internet');
    }
  }

  _changeLoadingState(bool _isLoading, bool time) {
    isLoading = _isLoading;
    _notify();
  }

  _changePageLoadingState(bool _isLoading, bool time) {
    isLoadingPage = _isLoading;
    _notify();
  }

  noDataLogic(int pagenum) {
    page = pagenum - 1;
    stop = true;
    _notify();
  }

  _notify() {
    if (mounted) setState(() {});
  }

  String getDateItem(int index) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    var outputDateFormate = DateFormat('dd-MM-yyyy');

    var startDate = inputFormat.parse(userList[index].registered?.date ?? '');
    var registeredDate = outputDateFormate.format(startDate);

    return registeredDate;
  }

  String getTime(int index) {
    var inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    var outputDateFormate = DateFormat('h:mm a');

    var startDate = inputFormat.parse(userList[index].registered?.date ?? '');
    var registeredDate = outputDateFormate.format(startDate);

    return registeredDate;
  }
}
