import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams/bloc/home_bloc/home_cubit.dart';
import 'package:teams/utils/const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teams/views/home_screen/home_page.dart';

import '../../api/api.dart';

class HomeTabControllerPage extends StatefulWidget {
  const HomeTabControllerPage({super.key});

  @override
  State<HomeTabControllerPage> createState() => _HomeTabControllerPageState();
}

class _HomeTabControllerPageState extends State<HomeTabControllerPage> {
  ApiHandler apiHandler = ApiHandler();

  int selectedIndex = 2;

  _onItemTapped(int index) {
    log(index.toString());
    switch (index) {
      case 2:
        return BlocProvider(
          create: (context) => HomeCubit(repository: apiHandler),
          child: const HomePage(),
        );
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _onItemTapped(selectedIndex),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          shape: const CircularNotchedRectangle(),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16.0),
                  topLeft: Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              child: BottomNavigationBar(
                backgroundColor:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                onTap: _onItemTapped,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: primaryColor,
                unselectedItemColor: iconColor,
                currentIndex: selectedIndex,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(iconHome),
                    activeIcon: SvgPicture.asset(iconHome),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(iconLoan), label: "Loans"),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(iconContract),
                    label: "Contracts",
                  ),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(iconTeam), label: "Teams"),
                  BottomNavigationBarItem(
                      icon: SvgPicture.asset(iconChat), label: "Chat"),
                ],
              ),
            ),
          ),
        ));
  }
}
