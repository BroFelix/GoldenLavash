import 'package:bloc/bloc.dart';
import 'package:golden_app/bloc/home/home_event.dart';
import 'package:golden_app/bloc/home/home_state.dart';
import 'package:golden_app/data/data_init.dart';
import 'package:golden_app/data/db/database.dart';
import 'package:golden_app/models/estimate.dart';
import 'package:golden_app/models/product.dart';
import 'package:golden_app/models/provider.dart';
import 'package:golden_app/models/resource.dart';
import 'package:golden_app/persistence/repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final repository = Repository();

  HomeBloc(HomeState initialState) : super(initialState);

  HomeState get initialState => HomeInit();

  List<Estimate> getEstimateData() {
    List<Estimate> estimateList = [];
    Floor.instance.database.then((db) => db.estimateDao.getAllEstimates().then(
        (est) => est
            .forEach((e) => estimateList.add(Estimate.fromJson(e.toJson())))));
    return estimateList;
  }

  List<Product> getProducts() {
    List<Product> products = [];
    Floor.instance.database.then((db) => db.productDao.getAllProducts().then(
        (e) => e.forEach(
            (element) => products.add(Product.fromJson(element.toJson())))));
    return products;
  }

  List<Resource> getResources() {
    List<Resource> resources = [];
    Floor.instance.database.then((db) => db.resourceDao.getAllResources().then(
        (value) => value.forEach(
            (element) => resources.add(Resource.fromJson(element.toJson())))));
    return resources;
  }

  List<Provider> getProviders() {
    List<Provider> providers = [];
    Floor.instance.database.then((db) => db.providerDao.getAllProviders().then(
        (value) => value.forEach(
            (element) => providers.add(Provider.fromJson(element.toJson())))));
    return providers;
  }

  init() {
    DataInitialisator.getInstance().then((di) => di.populateCompany().then(
        (companies) =>
            di.populateProvider().then((providers) =>
                di.populateProduct()
            .then((products) => di
                .populateEstimate()
                .then((estimates) => di.populateResource())
                .then((resources) => di.populateExpenses())
                .then((expenses) => di.populateManufactures())
                .then((manufactures) => di.populateEstimateResource())))));
  }

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is GetData) {
      init();
      yield initialState;
    } else if (event is HomeGoToEstimate) {
      List<Estimate> estimateList = [];
      estimateList = getEstimateData();
      yield HomeLoadEstimate(estimateList);
    } else if (event is HomeGoToOutlay) {
      // yield initialState;
      final outlayCategory = await repository.fetchOutlayCategory();
      yield HomeLoadOutlay(outlayCategory);
    } else if (event is HomeGoToProducts) {
      // yield initialState;
      final products = getProducts();
      yield HomeLoadProducts(products);
    } else if (event is HomeGoToProvider) {
      // yield initialState;
      final provider = getProviders();
      yield HomeLoadProvider(provider);
    } else if (event is HomeGoToResources) {
      // yield initialState;
      final resource = getResources();
      yield HomeLoadResources(resource);
    } else if (event is HomeComplete) {}
  }
}
