import 'dart:async';

import 'package:floor/floor.dart';
import 'package:golden_app/data/constants.dart';
import 'package:golden_app/data/db/dao/company.dart';
import 'package:golden_app/data/db/dao/estimate.dart';
import 'package:golden_app/data/db/dao/estimate_item.dart';
import 'package:golden_app/data/db/dao/estimate_resource.dart';
import 'package:golden_app/data/db/dao/outlay_category.dart';
import 'package:golden_app/data/db/dao/outlay_item.dart';
import 'package:golden_app/data/db/dao/product.dart';
import 'package:golden_app/data/db/dao/provider.dart';
import 'package:golden_app/data/db/dao/resource.dart';
import 'package:golden_app/data/db/model/company.dart';
import 'package:golden_app/data/db/model/estimate.dart';
import 'package:golden_app/data/db/model/estimate_item.dart';
import 'package:golden_app/data/db/model/estimate_resource.dart';
import 'package:golden_app/data/db/model/outlay_category.dart';
import 'package:golden_app/data/db/model/outlay_item.dart';
import 'package:golden_app/data/db/model/product.dart';
import 'package:golden_app/data/db/model/provider.dart';
import 'package:golden_app/data/db/model/resource.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'base.g.dart';

@Database(version: Constants.DB_VERSION, entities: [
  Company,
  Estimate,
  EstimateResource,
  Product,
  Provider,
  Resource,
  EstimateItem,
  OutlayCategory,
  OutlayItem,
])
abstract class AppDatabase extends FloorDatabase {
  CompanyDao get companyDao;

  EstimateDao get estimateDao;

  EstimateItemDao get estimateItemDao;

  EstimateResourceDao get estimateResourceDao;

  ProductDao get productDao;

  ProviderDao get providerDao;

  ResourceDao get resourceDao;

  OutlayCategoryDao get outlayCategoryDao;

  OutlayItemDao get outlayItemDao;
}
