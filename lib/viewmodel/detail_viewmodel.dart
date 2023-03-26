import 'package:flutter/material.dart';
import 'package:largo/models/detail_model.dart';
import 'package:largo/providers/detail_provider.dart';


class DetailViewmodel {
  var provider = DetailProvider();

  Future<DetailModel> detailById(int id) {
    return provider.getDetail(id);
  }

}