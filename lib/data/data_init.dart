import 'package:golden_app/data/db/config/base.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/company.dart';
import 'package:golden_app/data/db/model/estimate.dart';
import 'package:golden_app/data/db/model/estimate_resource.dart';
import 'package:golden_app/data/db/model/outlay_category.dart';
import 'package:golden_app/data/db/model/outlay_item.dart';
import 'package:golden_app/data/db/model/product.dart';
import 'package:golden_app/data/db/model/provider.dart';
import 'package:golden_app/data/db/model/resource.dart';
import 'package:golden_app/services/api/api.dart';

import 'db/model/estimate_item.dart';

class DataInitialisator {
  ApiService api;
  AppDatabase db;

  DataInitialisator._(this.api, this.db);

  static DataInitialisator _instance;

  static Future<DataInitialisator> getInstance() async {
    if (_instance == null) {
      var api = ApiService.getInstance();
      var db = await Floor.instance.database;
      _instance = DataInitialisator._(api, db);
    }
    return _instance;
  }

  Future populateCompany() async {
    var company = await api.getCompany();
    List<Company> companies = [];
    company.results.forEach((e) => companies.add(Company.fromJson(e.toJson())));
    return await db.companyDao.insertCompanies(companies);
  }

  Future populateEstimate() async {
    var estimateResponse = await api.getEstimates();
    List<Estimate> estimates = [];
    // print('Init created = ${estimateResponse.results[0].created}');
    estimateResponse.results
        .forEach((e) => estimates.add(Estimate.fromJson(e.toJson())));
    return await db.estimateDao.insertEstimates(estimates);
  }

  Future populateProduct() async {
    var product = await api.getProducts();
    List<Product> products = [];
    product.results.forEach((e) => products.add(Product.fromJson(e.toJson())));
    return await db.productDao.insertProducts(products);
  }

  Future populateProvider() async {
    var provider = await api.getProvider();
    List<Provider> providers = [];
    provider.results
        .forEach((e) => providers.add(Provider.fromJson(e.toJson())));
    return await db.providerDao.insertProviders(providers);
  }

  Future populateResource() async {
    var resource = await api.getResource();
    List<Resource> resources = [];
    resource.results
        .forEach((e) => resources.add(Resource.fromJson(e.toJson())));
    return await db.resourceDao.insertResources(resources);
  }

  Future populateEstimateResource() async {
    var resource = await api.getEstimateResources();
    List<EstimateResource> resources = [];
    resource.results
        .forEach((e) => resources.add(EstimateResource.fromJson(e.toJson())));
    return await db.estimateResourceDao.insertEstimateResources(resources);
  }

  Future populateEstimateItem() async {
    var item = await api.getEstimateItem();
    List<EstimateItem> items = [];
    item.results.forEach((e) => items.add(EstimateItem.fromJson(e.toJson())));
    return await db.estimateItemDao.insertEstimateItems(items);
  }

  Future populateOutlayCategory() async {
    var outlayCat = await api.getOutlayCategory();
    List<OutlayCategory> outlayCats = [];
    outlayCat.results.forEach(
        (element) => outlayCats.add(OutlayCategory.fromJson(element.toJson())));
    return await db.outlayCategoryDao.insertAllOutlayCategories(outlayCats);
  }

  Future populateOutlayItem() async {
    var outlayItem = await api.getOutlayItem();
    List<OutlayItem> outlayItems = [];
    outlayItem.results
        .forEach((e) => outlayItems.add(OutlayItem.fromJson(e.toJson())));
    return await db.outlayItemDao.insertAllOutlayItems(outlayItems);
  }
}
