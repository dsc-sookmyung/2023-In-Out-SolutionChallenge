import 'package:flutter/material.dart';
import 'package:largo/models/detail_model.dart';
import 'package:largo/providers/detail_provider.dart';
import 'package:largo/viewmodel/detail_viewmodel.dart';

enum LoadingStatus { completed, searching, empty }

class detailListviewmodel extends ChangeNotifier{
  //초기에 로딩 데이터 없음
  LoadingStatus loadingStatus = LoadingStatus.empty;

  List<DetailViewmodel> details = List<DetailViewmodel>();

  //기사 가져오기
  void topHeadLines() async {
    //기사 가져오고 현재 상태 로딩중으로 변경
    List<DetailModel> detail = await DetailProvider().getDetail();
    loadingStatus = LoadingStatus.searching;
    notifyListeners();

    this.details = detail
        .map((item) => detailListviewmodel(detail: item))
        .toList();

    //가져온 데이터가 비어있으면 빈 상태 아니면 성공 상태
    this.loadingStatus =
    this.details.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }

}