// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/components/tenger_error.dart';
import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:abico_warehouse/data/blocs/hr/hr_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/screen/login/login_screen.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  HrListBloc _hrListBloc;

  @override
  void initState() {
    super.initState();
    _hrListBloc = HrListBloc();
    _getHr();
  }

  @override
  void dispose() {
    _hrListBloc.close();
    super.dispose();
  }

  Future<void> _getHr() async {
    final user = await DBProvider.db.getUser();
    setState(() {
      _hrListBloc.add(Hr(uid: user.uid.toString()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder(
              bloc: _hrListBloc,
              builder: (context, state) {
                if (state is HrLoading) {
                  return const Center(
                    child: SizedBox(
                      height: 70,
                      width: 70,
                      child: TengerLoadingIndicator(),
                    ),
                  );
                } else if (state is HrError) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: TengerError(error: state.error),
                    ),
                  );
                } else if (state is HrLoaded) {
                  final firstResultHr = state.resultHr.first;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: const EdgeInsets.only(
                                top: 15, left: 15, right: 15, bottom: 30),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(104, 26, 81, 0.9),
                              borderRadius: BorderRadius.circular(50),
                              image: firstResultHr.image1920 != null
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(
                                        base64Decode(firstResultHr.image1920),
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  firstResultHr.name ?? '',
                                  style: const TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  firstResultHr.jobTitle ?? '',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            _buildContainer(
                              Icons.phone,
                              const Text(
                                'Утас',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                firstResultHr.mobilePhone ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            _buildContainer(
                              Icons.mail,
                              const Text(
                                'Э-майл',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                firstResultHr.workEmail ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            _buildContainer(
                              Icons.home,
                              const Text(
                                'Ажлын Байршил',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                firstResultHr.workLocation ?? '',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 156,
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.topRight,
                                          end: Alignment.bottomLeft,
                                          colors: [
                                            Color.fromARGB(228, 4, 38, 150),
                                            Color.fromARGB(206, 9, 104, 160),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.transparent,
                                          shadowColor: Colors.transparent,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                            (_) => false,
                                          );
                                        },
                                        child: const Text(Language.LABEL_OUT),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Text(
                    'Мэдээлэл олдсонгүй',
                    textAlign: TextAlign.center,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(IconData icon, Widget defaultText, Widget state) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 40,
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [defaultText, state],
        ),
      ],
    );
  }
}
