import 'dart:async';

import 'package:floor/floor.dart';
import 'package:golden_app/data/constants.dart';
import 'package:golden_app/data/db/dao/company.dart';
import 'package:golden_app/data/db/dao/estimate.dart';
import 'package:golden_app/data/db/dao/estimate_resource.dart';
import 'package:golden_app/data/db/dao/expense.dart';
import 'package:golden_app/data/db/dao/manufacture.dart';
import 'package:golden_app/data/db/dao/product.dart';
import 'package:golden_app/data/db/dao/provider.dart';
import 'package:golden_app/data/db/dao/resource.dart';
import 'package:golden_app/data/db/model/company.dart';
import 'package:golden_app/data/db/model/estimate.dart';
import 'package:golden_app/data/db/model/expense.dart';
import 'package:golden_app/data/db/model/manufacture.dart';
import 'package:golden_app/data/db/model/product.dart';
import 'package:golden_app/data/db/model/provider.dart';
import 'package:golden_app/data/db/model/estimate_resource.dart';
import 'package:golden_app/data/db/model/resource.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'base.g.dart';

@Database(version: Constants.DB_VERSION, entities: [
  Company,
  Estimate,
  EstimateResource,
  Expense,
  Manufacture,
  Product,
  Provider,
  Resource,
])
abstract class AppDatabase extends FloorDatabase {
  CompanyDao get companyDao;

  EstimateDao get estimateDao;

  EstimateResourceDao get estimateResourceDao;

  ExpenseDao get expenseDao;

  ManufactureDao get manufactureDao;

  ProductDao get productDao;

  ProviderDao get providerDao;

  ResourceDao get resourceDao;
}
