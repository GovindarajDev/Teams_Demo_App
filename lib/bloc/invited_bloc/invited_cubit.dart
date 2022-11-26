import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teams/api/api.dart';
import 'package:teams/models/invite_model.dart';

part 'invited_state.dart';

class InvitedCubit extends Cubit<InvitedState> {
  Repository? repository;
  InvitedCubit({@required this.repository}) : super(InvitedInitial());

  sendInvite(email, roleIndex) async {
    try {
      repository!.sendInvite(email, roleIndex).then((value) {
        if (value != null) {
          InviteModel model = InviteModel.fromJson(value);
          if (model.errorFlag == "EMAIL_EXISTS") {
            emit(InvitedFailed(message:model.message));
          } else if (model.errorFlag == "SUCCESS") {
            emit(InvitedSuccess());
          }
        } else {
          emit(InvitedError(message: "Invalid User - Token Expired"));
        }
      });
    } on Exception catch (e) {
      log(e.toString(), name: "CUBIT");
    }
  }
}
