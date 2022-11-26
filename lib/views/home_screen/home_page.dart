import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teams/bloc/home_bloc/home_cubit.dart';
import 'package:teams/bloc/theme_bloc/theme_cubit.dart';
import 'package:teams/models/invite_list_model.dart';
import 'package:teams/utils/const.dart';
import 'package:teams/utils/utils.dart';
import 'package:teams/utils/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contacts>? contacts = [];
  List<Invites>? invites = [];
  getDataFromApi() async {
    if (await isConnected()) {
      BlocProvider.of<HomeCubit>(context).getContactAndInviteListFromApi();
    } else {
      showSnackBar(noInternetMessage, context);
    }
  }

  @override
  void initState() {
    getDataFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: Theme.of(context).appBarTheme.elevation,
        backgroundColor: Theme.of(context).colorScheme.background,
        title: AppText(
          data: "Teams",
          color: Theme.of(context).textTheme.headline1?.color,
          size: width(context) * 0.09,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: Theme.of(context).appBarTheme.centerTitle,
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<ThemeCubit>(context).addTheme();
            },
            icon: Icon(
              Icons.search,
              color: Theme.of(context).iconTheme.color,
              size: 32.0,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => formshow(context, inviteRoute),
        highlightElevation: 30.0,
        elevation: 10.0,
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeLoading) {
            //show loader
          } else if (state is HomeSuccess) {
            contacts = state.data?.contacts;
            invites = state.data!.invites;
          } else if (state is HomeFailed) {
            showSnackBar(state.message, context);
          } else if (state is HomeError) {
            showSnackBar(state.message, context);
          }
        },
        builder: (context, state) {
          return HomePageUI(
            contacts: contacts,
            invites: invites,
          );
        },
      ),
    );
  }
}

class HomePageUI extends StatelessWidget {
  final List<Contacts>? contacts;
  final List<Invites>? invites;
  const HomePageUI(
      {super.key, @required this.contacts, @required this.invites});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // all people section
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "All people · ${[
                  ...contacts!,
                  ...invites!
                ].length.toString()}",
                size: width(context) * 0.04,
                color: txtLightColor,
                fontWeight: FontWeight.w500,
              ),
              AppText(
                data: "See all",
                size: width(context) * 0.04,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        verticalSpacer(32.0),
        Expanded(
          flex: 0,
          child: SizedBox(
            height: height(context) / 3,
            child: ListView.builder(
              // shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: contacts!.length,
              itemBuilder: (context, index) {
                var firstName = contacts![index].firstname != null
                    ? contacts![index].firstname!.trim()
                    : "Unknown";
                var lastName = contacts![index].lastname != null
                    ? contacts![index].lastname!.trim()
                    : "Unknown";
                return PeopleCard(
                  name: "$firstName $lastName",
                  status:
                      contacts![index].isactive == true ? "Active" : "Offline",
                  privilege: contacts![index].roleName,
                  isInvited: false,
                );
              },
            ),
          ),
        ),
        verticalSpacer(32.0),
        // invited people section
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Invited people · ${invites!.length.toString()}",
                size: width(context) * 0.04,
                color: txtLightColor,
                fontWeight: FontWeight.w500,
              ),
              AppText(
                data: "See all",
                size: width(context) * 0.04,
                color: primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
        ),
        verticalSpacer(32.0),
        Expanded(
          flex: 5,
          child: SizedBox(
            height: height(context) / 4,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: invites!.length,
              itemBuilder: (context, index) => PeopleCard(
                name: invites![index].email.toString(),
                status: '',
                privilege: invites![index].configName.toString(),
                isInvited: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PeopleCard extends StatelessWidget {
  final String? name;
  final String? status;
  final String? privilege;
  final bool? isInvited;
  const PeopleCard(
      {super.key,
      @required this.name,
      @required this.privilege,
      @required this.status,
      @required this.isInvited});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 0.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: ListTile(
        leading: Container(
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color:
                  isInvited == true ? bgInvitedNameCardColor : bgNameCardColor),
          alignment: Alignment.center,
          height: height(context) / 16,
          width: width(context) / 8,
          child: AppText(
            data: isInvited == false
                ? !name!.contains("@")
                    ? getInitial(string: name, limitTo: 2).toUpperCase()
                    : ''
                : getInitial(string: name, limitTo: 1).toUpperCase(), //
            size: width(context) * 0.04,
            color: Colors.white,
          ),
        ),
        title: AppText(
          data: name,
          size: width(context) * 0.03,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.headline1?.color,
        ),
        subtitle: AppText(
          data: isInvited == false ? status : privilege,
          size: width(context) * 0.03,
          fontWeight: FontWeight.w200,
          color: Theme.of(context).textTheme.headline1?.color,
        ),
        trailing: isInvited == false
            ? AppText(
                data: privilege,
                size: width(context) * 0.03,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).textTheme.headline1?.color,
              )
            : null,
      ),
    );
  }
}
