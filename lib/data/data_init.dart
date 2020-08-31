import 'package:golden_app/data/db/config/base.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/data/db/model/company.dart';
import 'package:golden_app/data/db/model/estimate.dart';
import 'package:golden_app/data/db/model/expense.dart';
import 'package:golden_app/data/db/model/manufacture.dart';
import 'package:golden_app/data/db/model/product.dart';
import 'package:golden_app/data/db/model/provider.dart';
import 'package:golden_app/data/db/model/estimate_resource.dart';
import 'package:golden_app/data/db/model/resource.dart';
import 'package:golden_app/services/api/api.dart';

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
    print('Init created = ${estimateResponse.results[0].created}');
    estimateResponse.results
        .forEach((e) => estimates.add(Estimate.fromJson(e.toJson())));
    return await db.estimateDao.insertEstimates(estimates);
  }

  Future populateExpenses() async {
    var expense = await api.getEstimates();
    List<Expense> expenses = [];
    expense.results.forEach((e) => expenses.add(Expense.fromJson(e.toJson())));
    return await db.expenseDao.insertExpenses(expenses);
  }

  Future populateManufactures() async {
    var manufacture = await api.getManufacture();
    List<Manufacture> manufactures = [];
    manufacture.results
        .forEach((e) => manufactures.add(Manufacture.fromJson(e.toJson())));
    return await db.manufactureDao.insertManufactures(manufactures);
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
}
