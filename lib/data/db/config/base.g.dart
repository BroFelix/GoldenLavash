// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  Callback _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CompanyDao _companyDaoInstance;

  EstimateDao _estimateDaoInstance;

  EstimateItemDao _estimateItemDaoInstance;

  EstimateResourceDao _estimateResourceDaoInstance;

  ProductDao _productDaoInstance;

  ProviderDao _providerDaoInstance;

  ResourceDao _resourceDaoInstance;

  OutlayCategoryDao _outlayCategoryDaoInstance;

  OutlayItemDao _outlayItemDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Company` (`id` INTEGER, `title` TEXT, `address` TEXT, `directorName` TEXT, `country` INTEGER, `city` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Estimate` (`id` INTEGER, `created` TEXT, `weekNumb` INTEGER, `docNumb` TEXT, `docDateStart` TEXT, `docDateEnd` TEXT, `status` INTEGER, `directorStatus` INTEGER, `directorStatusDate` TEXT, `counterStatus` INTEGER, `counterStatusDate` TEXT, `user` INTEGER, `company` INTEGER, `directorUser` INTEGER, `counterUser` INTEGER, FOREIGN KEY (`company`) REFERENCES `Company` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EstimateResource` (`id` INTEGER, `count` INTEGER, `countOld` INTEGER, `price` INTEGER, `amount` INTEGER, `status` INTEGER, `sendWarehouse` INTEGER, `acceptedWarehouse` INTEGER, `priceUsd` REAL, `rate` INTEGER, `company` INTEGER, `estimate` INTEGER, `resource` INTEGER, `provider` INTEGER, FOREIGN KEY (`company`) REFERENCES `Company` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`estimate`) REFERENCES `Estimate` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`provider`) REFERENCES `Provider` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`resource`) REFERENCES `Resource` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Product` (`id` INTEGER, `title` TEXT, `code` TEXT, `price` INTEGER, `boxCount` INTEGER, `company` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Provider` (`id` INTEGER, `name` TEXT, `contacts` TEXT, `registerDate` TEXT, `status` INTEGER, `registerUser` INTEGER, `itn` TEXT, `address` TEXT, `latitude` TEXT, `longitude` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Resource` (`id` INTEGER, `title` TEXT, `editType` INTEGER, `resourceType` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `EstimateItem` (`id` INTEGER, `count` INTEGER, `countOld` INTEGER, `price` INTEGER, `priceOld` INTEGER, `amount` INTEGER, `status` INTEGER, `priceUsd` REAL, `rate` INTEGER, `company` INTEGER, `estimate` INTEGER, `outlayItem` INTEGER, `provider` INTEGER, FOREIGN KEY (`company`) REFERENCES `Company` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`estimate`) REFERENCES `Estimate` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`outlayItem`) REFERENCES `OutlayItem` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`provider`) REFERENCES `Provider` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OutlayCategory` (`id` INTEGER, `title` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OutlayItem` (`id` INTEGER, `title` TEXT, `outlayCategory` INTEGER NOT NULL, FOREIGN KEY (`outlayCategory`) REFERENCES `OutlayCategory` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CompanyDao get companyDao {
    return _companyDaoInstance ??= _$CompanyDao(database, changeListener);
  }

  @override
  EstimateDao get estimateDao {
    return _estimateDaoInstance ??= _$EstimateDao(database, changeListener);
  }

  @override
  EstimateItemDao get estimateItemDao {
    return _estimateItemDaoInstance ??=
        _$EstimateItemDao(database, changeListener);
  }

  @override
  EstimateResourceDao get estimateResourceDao {
    return _estimateResourceDaoInstance ??=
        _$EstimateResourceDao(database, changeListener);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  ProviderDao get providerDao {
    return _providerDaoInstance ??= _$ProviderDao(database, changeListener);
  }

  @override
  ResourceDao get resourceDao {
    return _resourceDaoInstance ??= _$ResourceDao(database, changeListener);
  }

  @override
  OutlayCategoryDao get outlayCategoryDao {
    return _outlayCategoryDaoInstance ??=
        _$OutlayCategoryDao(database, changeListener);
  }

  @override
  OutlayItemDao get outlayItemDao {
    return _outlayItemDaoInstance ??= _$OutlayItemDao(database, changeListener);
  }
}

class _$CompanyDao extends CompanyDao {
  _$CompanyDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _companyInsertionAdapter = InsertionAdapter(
            database,
            'Company',
            (Company item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'address': item.address,
                  'directorName': item.directorName,
                  'country': item.country,
                  'city': item.city
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _companyMapper = (Map<String, dynamic> row) => Company(
      id: row['id'] as int,
      title: row['title'] as String,
      address: row['address'] as String,
      directorName: row['directorName'] as String,
      country: row['country'] as int,
      city: row['city'] as int);

  final InsertionAdapter<Company> _companyInsertionAdapter;

  @override
  Future<List<Company>> getAllCompanies() async {
    return _queryAdapter.queryList('SELECT * FROM Company',
        mapper: _companyMapper);
  }

  @override
  Future<Company> getCompany(int id) async {
    return _queryAdapter.query('SELECT * FROM Company Where id = ?',
        arguments: <dynamic>[id], mapper: _companyMapper);
  }

  @override
  Future<void> deleteAllCompanies() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Company');
  }

  @override
  Future<int> insertCompany(Company company) {
    return _companyInsertionAdapter.insertAndReturnId(
        company, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertCompanies(List<Company> companies) {
    return _companyInsertionAdapter.insertListAndReturnIds(
        companies, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceCompanies(List<Company> companies) async {
    if (database is sqflite.Transaction) {
      await super.replaceCompanies(companies);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.companyDao.replaceCompanies(companies);
      });
    }
  }
}

class _$EstimateDao extends EstimateDao {
  _$EstimateDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _estimateInsertionAdapter = InsertionAdapter(
            database,
            'Estimate',
            (Estimate item) => <String, dynamic>{
                  'id': item.id,
                  'created': item.created,
                  'weekNumb': item.weekNumb,
                  'docNumb': item.docNumb,
                  'docDateStart': item.docDateStart,
                  'docDateEnd': item.docDateEnd,
                  'status': item.status,
                  'directorStatus': item.directorStatus,
                  'directorStatusDate': item.directorStatusDate,
                  'counterStatus': item.counterStatus,
                  'counterStatusDate': item.counterStatusDate,
                  'user': item.user,
                  'company': item.company,
                  'directorUser': item.directorUser,
                  'counterUser': item.counterUser
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _estimateMapper = (Map<String, dynamic> row) => Estimate(
      id: row['id'] as int,
      created: row['created'] as String,
      weekNumb: row['weekNumb'] as int,
      docNumb: row['docNumb'] as String,
      docDateStart: row['docDateStart'] as String,
      docDateEnd: row['docDateEnd'] as String,
      status: row['status'] as int,
      directorStatus: row['directorStatus'] as int,
      directorStatusDate: row['directorStatusDate'] as String,
      counterStatus: row['counterStatus'] as int,
      counterStatusDate: row['counterStatusDate'] as String,
      user: row['user'] as int,
      company: row['company'] as int,
      directorUser: row['directorUser'] as int,
      counterUser: row['counterUser'] as int);

  final InsertionAdapter<Estimate> _estimateInsertionAdapter;

  @override
  Future<List<Estimate>> getAllEstimates() async {
    return _queryAdapter.queryList('SELECT * FROM Estimate',
        mapper: _estimateMapper);
  }

  @override
  Future<Estimate> getEstimate(int id) async {
    return _queryAdapter.query('SELECT * FROM Estimate Where id = ?',
        arguments: <dynamic>[id], mapper: _estimateMapper);
  }

  @override
  Future<void> deleteAllEstimates() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Estimate');
  }

  @override
  Future<int> insertEstimate(Estimate estimate) {
    return _estimateInsertionAdapter.insertAndReturnId(
        estimate, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertEstimates(List<Estimate> estimates) {
    return _estimateInsertionAdapter.insertListAndReturnIds(
        estimates, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceEstimates(List<Estimate> estimates) async {
    if (database is sqflite.Transaction) {
      await super.replaceEstimates(estimates);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.estimateDao.replaceEstimates(estimates);
      });
    }
  }
}

class _$EstimateItemDao extends EstimateItemDao {
  _$EstimateItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _estimateItemInsertionAdapter = InsertionAdapter(
            database,
            'EstimateItem',
            (EstimateItem item) => <String, dynamic>{
                  'id': item.id,
                  'count': item.count,
                  'countOld': item.countOld,
                  'price': item.price,
                  'priceOld': item.priceOld,
                  'amount': item.amount,
                  'status': item.status,
                  'priceUsd': item.priceUsd,
                  'rate': item.rate,
                  'company': item.company,
                  'estimate': item.estimate,
                  'outlayItem': item.outlayItem,
                  'provider': item.provider
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _estimateItemMapper = (Map<String, dynamic> row) => EstimateItem(
      id: row['id'] as int,
      count: row['count'] as int,
      countOld: row['countOld'] as int,
      price: row['price'] as int,
      priceOld: row['priceOld'] as int,
      amount: row['amount'] as int,
      status: row['status'] as int,
      priceUsd: row['priceUsd'] as double,
      rate: row['rate'] as int,
      company: row['company'] as int,
      estimate: row['estimate'] as int,
      outlayItem: row['outlayItem'] as int,
      provider: row['provider'] as int);

  final InsertionAdapter<EstimateItem> _estimateItemInsertionAdapter;

  @override
  Future<List<EstimateItem>> getAllEstimateItems() async {
    return _queryAdapter.queryList('SELECT * FROM EstimateItem',
        mapper: _estimateItemMapper);
  }

  @override
  Future<EstimateItem> getEstimateItem(int id) async {
    return _queryAdapter.query('SELECT * FROM EstimateItem Where id = ?',
        arguments: <dynamic>[id], mapper: _estimateItemMapper);
  }

  @override
  Future<void> deleteAllEstimateItems() async {
    await _queryAdapter.queryNoReturn('DELETE FROM EstimateItem');
  }

  @override
  Future<int> insertEstimateItem(EstimateItem estimateItem) {
    return _estimateItemInsertionAdapter.insertAndReturnId(
        estimateItem, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertEstimateItems(List<EstimateItem> estimateItems) {
    return _estimateItemInsertionAdapter.insertListAndReturnIds(
        estimateItems, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceEstimateItems(List<EstimateItem> estimateItems) async {
    if (database is sqflite.Transaction) {
      await super.replaceEstimateItems(estimateItems);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.estimateItemDao
            .replaceEstimateItems(estimateItems);
      });
    }
  }
}

class _$EstimateResourceDao extends EstimateResourceDao {
  _$EstimateResourceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _estimateResourceInsertionAdapter = InsertionAdapter(
            database,
            'EstimateResource',
            (EstimateResource item) => <String, dynamic>{
                  'id': item.id,
                  'count': item.count,
                  'countOld': item.countOld,
                  'price': item.price,
                  'amount': item.amount,
                  'status': item.status,
                  'sendWarehouse': item.sendWarehouse == null
                      ? null
                      : (item.sendWarehouse ? 1 : 0),
                  'acceptedWarehouse': item.acceptedWarehouse == null
                      ? null
                      : (item.acceptedWarehouse ? 1 : 0),
                  'priceUsd': item.priceUsd,
                  'rate': item.rate,
                  'company': item.company,
                  'estimate': item.estimate,
                  'resource': item.resource,
                  'provider': item.provider
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _estimateResourceMapper = (Map<String, dynamic> row) =>
      EstimateResource(
          id: row['id'] as int,
          count: row['count'] as int,
          countOld: row['countOld'] as int,
          price: row['price'] as int,
          amount: row['amount'] as int,
          status: row['status'] as int,
          sendWarehouse: row['sendWarehouse'] == null
              ? null
              : (row['sendWarehouse'] as int) != 0,
          acceptedWarehouse: row['acceptedWarehouse'] == null
              ? null
              : (row['acceptedWarehouse'] as int) != 0,
          priceUsd: row['priceUsd'] as double,
          rate: row['rate'] as int,
          company: row['company'] as int,
          estimate: row['estimate'] as int,
          resource: row['resource'] as int,
          provider: row['provider'] as int);

  final InsertionAdapter<EstimateResource> _estimateResourceInsertionAdapter;

  @override
  Future<List<EstimateResource>> getAllEstimateResources() async {
    return _queryAdapter.queryList('SELECT * FROM EstimateResource',
        mapper: _estimateResourceMapper);
  }

  @override
  Future<EstimateResource> getEstimateResource(int id) async {
    return _queryAdapter.query('SELECT * FROM EstimateResource Where id = ?',
        arguments: <dynamic>[id], mapper: _estimateResourceMapper);
  }

  @override
  Future<void> deleteAllEstimateResources() async {
    await _queryAdapter.queryNoReturn('DELETE FROM EstimateResource');
  }

  @override
  Future<int> insertEstimateResource(EstimateResource estimate) {
    return _estimateResourceInsertionAdapter.insertAndReturnId(
        estimate, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertEstimateResources(
      List<EstimateResource> estimateResources) {
    return _estimateResourceInsertionAdapter.insertListAndReturnIds(
        estimateResources, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceEstimateResources(
      List<EstimateResource> estimateResources) async {
    if (database is sqflite.Transaction) {
      await super.replaceEstimateResources(estimateResources);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.estimateResourceDao
            .replaceEstimateResources(estimateResources);
      });
    }
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productInsertionAdapter = InsertionAdapter(
            database,
            'Product',
            (Product item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'code': item.code,
                  'price': item.price,
                  'boxCount': item.boxCount,
                  'company': item.company
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _productMapper = (Map<String, dynamic> row) => Product(
      id: row['id'] as int,
      title: row['title'] as String,
      code: row['code'] as String,
      price: row['price'] as int,
      boxCount: row['boxCount'] as int,
      company: row['company'] as int);

  final InsertionAdapter<Product> _productInsertionAdapter;

  @override
  Future<List<Product>> getAllProducts() async {
    return _queryAdapter.queryList('SELECT * FROM Product',
        mapper: _productMapper);
  }

  @override
  Future<Product> getProduct(int id) async {
    return _queryAdapter.query('SELECT * FROM Product Where id = ?',
        arguments: <dynamic>[id], mapper: _productMapper);
  }

  @override
  Future<void> deleteAllProducts() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Product');
  }

  @override
  Future<int> insertProduct(Product product) {
    return _productInsertionAdapter.insertAndReturnId(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertProducts(List<Product> products) {
    return _productInsertionAdapter.insertListAndReturnIds(
        products, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceProducts(List<Product> products) async {
    if (database is sqflite.Transaction) {
      await super.replaceProducts(products);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.productDao.replaceProducts(products);
      });
    }
  }
}

class _$ProviderDao extends ProviderDao {
  _$ProviderDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _providerInsertionAdapter = InsertionAdapter(
            database,
            'Provider',
            (Provider item) => <String, dynamic>{
                  'id': item.id,
                  'name': item.name,
                  'contacts': item.contacts,
                  'registerDate': item.registerDate,
                  'status': item.status == null ? null : (item.status ? 1 : 0),
                  'registerUser': item.registerUser,
                  'itn': item.itn,
                  'address': item.address,
                  'latitude': item.latitude,
                  'longitude': item.longitude
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _providerMapper = (Map<String, dynamic> row) => Provider(
      id: row['id'] as int,
      name: row['name'] as String,
      contacts: row['contacts'] as String,
      registerDate: row['registerDate'] as String,
      status: row['status'] == null ? null : (row['status'] as int) != 0,
      registerUser: row['registerUser'] as int,
      itn: row['itn'] as String,
      address: row['address'] as String,
      latitude: row['latitude'] as String,
      longitude: row['longitude'] as String);

  final InsertionAdapter<Provider> _providerInsertionAdapter;

  @override
  Future<List<Provider>> getAllProviders() async {
    return _queryAdapter.queryList('SELECT * FROM Provider',
        mapper: _providerMapper);
  }

  @override
  Future<Provider> getProvider(int id) async {
    return _queryAdapter.query('SELECT * FROM Provider Where id = ?',
        arguments: <dynamic>[id], mapper: _providerMapper);
  }

  @override
  Future<void> deleteAllProviders() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Provider');
  }

  @override
  Future<int> insertProvider(Provider provider) {
    return _providerInsertionAdapter.insertAndReturnId(
        provider, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertProviders(List<Provider> providers) {
    return _providerInsertionAdapter.insertListAndReturnIds(
        providers, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceProviders(List<Provider> providers) async {
    if (database is sqflite.Transaction) {
      await super.replaceProviders(providers);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.providerDao.replaceProviders(providers);
      });
    }
  }
}

class _$ResourceDao extends ResourceDao {
  _$ResourceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _resourceInsertionAdapter = InsertionAdapter(
            database,
            'Resource',
            (Resource item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'editType': item.editType,
                  'resourceType': item.resourceType
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _resourceMapper = (Map<String, dynamic> row) => Resource(
      id: row['id'] as int,
      title: row['title'] as String,
      editType: row['editType'] as int,
      resourceType: row['resourceType'] as String);

  final InsertionAdapter<Resource> _resourceInsertionAdapter;

  @override
  Future<List<Resource>> getAllResources() async {
    return _queryAdapter.queryList('SELECT * FROM Resource',
        mapper: _resourceMapper);
  }

  @override
  Future<Resource> getResource(int id) async {
    return _queryAdapter.query('SELECT * FROM Resource Where id = ?',
        arguments: <dynamic>[id], mapper: _resourceMapper);
  }

  @override
  Future<void> deleteAllResources() async {
    await _queryAdapter.queryNoReturn('DELETE FROM Resource');
  }

  @override
  Future<int> insertResource(Resource resource) {
    return _resourceInsertionAdapter.insertAndReturnId(
        resource, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertResources(List<Resource> resources) {
    return _resourceInsertionAdapter.insertListAndReturnIds(
        resources, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceResources(List<Resource> resources) async {
    if (database is sqflite.Transaction) {
      await super.replaceResources(resources);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.resourceDao.replaceResources(resources);
      });
    }
  }
}

class _$OutlayCategoryDao extends OutlayCategoryDao {
  _$OutlayCategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _outlayCategoryInsertionAdapter = InsertionAdapter(
            database,
            'OutlayCategory',
            (OutlayCategory item) =>
                <String, dynamic>{'id': item.id, 'title': item.title});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _outlayCategoryMapper = (Map<String, dynamic> row) =>
      OutlayCategory(id: row['id'] as int, title: row['title'] as String);

  final InsertionAdapter<OutlayCategory> _outlayCategoryInsertionAdapter;

  @override
  Future<List<OutlayCategory>> getAllOutlayCategories() async {
    return _queryAdapter.queryList('SELECT * FROM OutlayCategory',
        mapper: _outlayCategoryMapper);
  }

  @override
  Future<OutlayCategory> getOutlayCategory(int id) async {
    return _queryAdapter.query('SELECT * FROM OutlayCategory Where id = ?',
        arguments: <dynamic>[id], mapper: _outlayCategoryMapper);
  }

  @override
  Future<void> deleteAllOutlayCategories() async {
    await _queryAdapter.queryNoReturn('DELETE FROM OutlayCategory');
  }

  @override
  Future<int> insertOutlayCategory(OutlayCategory outlayCategory) {
    return _outlayCategoryInsertionAdapter.insertAndReturnId(
        outlayCategory, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllOutlayCategories(
      List<OutlayCategory> outlayCategories) {
    return _outlayCategoryInsertionAdapter.insertListAndReturnIds(
        outlayCategories, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceOutlayCategories(
      List<OutlayCategory> outlayCategories) async {
    if (database is sqflite.Transaction) {
      await super.replaceOutlayCategories(outlayCategories);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.outlayCategoryDao
            .replaceOutlayCategories(outlayCategories);
      });
    }
  }
}

class _$OutlayItemDao extends OutlayItemDao {
  _$OutlayItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _outlayItemInsertionAdapter = InsertionAdapter(
            database,
            'OutlayItem',
            (OutlayItem item) => <String, dynamic>{
                  'id': item.id,
                  'title': item.title,
                  'outlayCategory': item.outlayCategory
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _outlayItemMapper = (Map<String, dynamic> row) => OutlayItem(
      id: row['id'] as int,
      title: row['title'] as String,
      outlayCategory: row['outlayCategory'] as int);

  final InsertionAdapter<OutlayItem> _outlayItemInsertionAdapter;

  @override
  Future<List<OutlayItem>> getAllOutlayItems() async {
    return _queryAdapter.queryList('SELECT * FROM OutlayItem',
        mapper: _outlayItemMapper);
  }

  @override
  Future<OutlayItem> getOutlayItem(int id) async {
    return _queryAdapter.query('SELECT * FROM OutlayItem Where id = ?',
        arguments: <dynamic>[id], mapper: _outlayItemMapper);
  }

  @override
  Future<List<OutlayItem>> getOutlaysByCategory(int outlayCategory) async {
    return _queryAdapter.queryList(
        'SELECT * FROM OutlayItem Where outlayCategory = ?',
        arguments: <dynamic>[outlayCategory],
        mapper: _outlayItemMapper);
  }

  @override
  Future<void> deleteAllOutlayItems() async {
    await _queryAdapter.queryNoReturn('DELETE FROM OutlayItem');
  }

  @override
  Future<int> insertOutlayItem(OutlayItem item) {
    return _outlayItemInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllOutlayItems(List<OutlayItem> items) {
    return _outlayItemInsertionAdapter.insertListAndReturnIds(
        items, OnConflictStrategy.replace);
  }

  @override
  Future<void> replaceOutlayItems(List<OutlayItem> outlayItems) async {
    if (database is sqflite.Transaction) {
      await super.replaceOutlayItems(outlayItems);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.outlayItemDao.replaceOutlayItems(outlayItems);
      });
    }
  }
}
