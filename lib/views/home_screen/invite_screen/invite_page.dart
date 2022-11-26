import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams/bloc/invited_bloc/invited_cubit.dart';
import 'package:teams/utils/const.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/utils.dart';
import '../../../utils/widgets.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({super.key});

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: Theme.of(context).appBarTheme.elevation,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () => goBack(context),
              child: SvgPicture.asset(iconBack,
                  color: Theme.of(context).iconTheme.color),
            )),
      ),
      body: BlocConsumer<InvitedCubit, InvitedState>(
        listener: (context, state) {
          if (state is InvitedLoading) {
          } else if (state is InvitedSuccess) {
            goBack(context);
          } else if (state is InvitedFailed) {
            showSnackBar(state.message, context);
          } else if (state is InvitedError) {
            showSnackBar(state.message, context);
          }
        },
        builder: (context, state) {
          return const InvitePageUI();
        },
      ),
    );
  }
}

class InvitePageUI extends StatefulWidget {
  const InvitePageUI({super.key});

  @override
  State<InvitePageUI> createState() => _InvitePageUIState();
}

class _InvitePageUIState extends State<InvitePageUI> {
  final emailController = TextEditingController();
  final roleController = TextEditingController();
  List<String>? roles = ["Admin", "Approver", "Preparer", "Viewer", "Employee"];
  int? selectedRole = 0;

  teamRoles({final String? roleName, final int? index}) {
    return Card(
      color: selectedRole == index
          ? primaryColor.withOpacity(0.1)
          : Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListTile(
        onTap: () => setState(() {
          selectedRole = index;
          goBack(context);
        }),
        title: AppText(
          data: roleName,
          size: width(context) * 0.03,
          fontWeight: FontWeight.bold,
          color: selectedRole == index
              ? primaryColor
              : Theme.of(context).textTheme.headline1?.color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            children: [
              // title
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 16.0),
                child: AppText(
                  data: "Invite",
                  size: width(context) * 0.07,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline1?.color,
                ),
              ),
              verticalSpacer(32.0),
              // textformfields
              Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Theme.of(context).cardColor),
                padding: const EdgeInsets.only(top: 8.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: AppTextField(
                  controller: emailController,
                  label: "Business email",
                ),
              ),
              Container(
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Theme.of(context).cardColor,
                    ),
                padding: const EdgeInsets.only(top: 8.0),
                margin:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: AppTextField(
                  isReadyOnly: true,
                  controller: roleController,
                  hint: roles![selectedRole!],
                  icon: Icons.keyboard_arrow_down,
                  onTaps: () {
                    showModalBottomSheet(
                        enableDrag: true,
                        context: context,
                        isDismissible: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        elevation: 8.0,
                        builder: (context) {
                          return Container(
                              decoration: ShapeDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ),
                              ),
                              height: height(context) / 2,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: SvgPicture.asset(iconDrag),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: AppText(
                                      data: "Team roles",
                                      size: width(context) * 0.04,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          ?.color,
                                    ),
                                  ),
                                  verticalSpacer(32.0),
                                  Expanded(
                                    child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: roles!.length,
                                      itemBuilder: (context, index) =>
                                          teamRoles(
                                              roleName: roles![index],
                                              index: index),
                                    ),
                                  ),
                                ],
                              ));
                        });
                  },
                ),
              ),
            ],
          ),
        ),
        //  button
        Expanded(
            flex: 0,
            child: AppButton(
              buttonName: "Continue",
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              onpress: () async {
                if (emailValidator(emailController.text)) {
                  // api call
                  if (await isConnected()) {
                    BlocProvider.of<InvitedCubit>(context)
                        .sendInvite(emailController.text, selectedRole! + 1);
                  } else {
                    showSnackBar(noInternetMessage, context);
                  }
                } else {
                  showSnackBar("Invalid Email", context);
                }
              },
            )),
      ],
    );
  }
}
