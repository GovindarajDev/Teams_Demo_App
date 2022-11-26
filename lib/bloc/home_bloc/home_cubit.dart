import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:teams/api/api.dart';
import 'package:teams/models/invite_list_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  Repository? repository;
  HomeCubit({@required this.repository}) : super(HomeInitial());

  getContactAndInviteListFromApi() async {
    try {
      repository!.getContactAndInviteList().then((value) {
        emit(HomeLoading());
        if (value != null) {
          InviteListModel model = InviteListModel.fromJson(value);
          if (model.errorFlag == "SUCCESS") {
            if (!isClosed) {
              emit(HomeSuccess(data: model.data));
            }
          } else {
            emit(HomeFailed(message: model.message));
          }
        } else {
          emit(HomeError(message: "Token Error"));
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }
}
