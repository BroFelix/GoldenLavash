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

  EstimateResourceDao _estimateResourceDaoInstance;

  ExpenseDao _expenseDaoInstance;

  ManufactureDao _manufactureDaoInstance;

  ProductDao _productDaoInstance;

  ProviderDao _providerDaoInstance;

  ResourceDao _resourceDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `EstimateResource` (`id` INTEGER, `count` INTEGER, `countOld` INTEGER, `price` INTEGER, `amount` INTEGER, `status` INTEGER, `sendWarehouse` INTEGER, `acceptedWarehouse` INTEGER, `company` INTEGER, `estimate` INTEGER, `resource` INTEGER, `provider` INTEGER, FOREIGN KEY (`company`) REFERENCES `Company` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`estimate`) REFERENCES `Estimate` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`provider`) REFERENCES `Provider` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`resource`) REFERENCES `Resource` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Expense` (`id` INTEGER, `count` INTEGER, `countOld` INTEGER, `price` INTEGER, `amount` INTEGER, `status` INTEGER, `sendWarehouse` INTEGER, `acceptedWarehouse` INTEGER, `company` INTEGER, `estimate` INTEGER, `resource` INTEGER, `provider` INTEGER, FOREIGN KEY (`company`) REFERENCES `Company` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`estimate`) REFERENCES `Estimate` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`resource`) REFERENCES `Resource` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`provider`) REFERENCES `Provider` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Manufacture` (`id` INTEGER, `resource` INTEGER, `count` INTEGER, `selfPrice` INTEGER, `productTitle` TEXT, FOREIGN KEY (`resource`) REFERENCES `Resource` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Product` (`id` INTEGER, `title` TEXT, `code` TEXT, `price` INTEGER, `boxCount` INTEGER, `company` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Provider` (`id` INTEGER, `name` TEXT, `contacts` TEXT, `registerDate` TEXT, `status` INTEGER, `registerUser` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Resource` (`id` INTEGER, `title` TEXT, `editType` INTEGER, `resourceType` TEXT, PRIMARY KEY (`id`))');

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
  EstimateResourceDao get estimateResourceDao {
    return _estimateResourceDaoInstance ??=
        _$EstimateResourceDao(database, changeListener);
  }

  @override
  ExpenseDao get expenseDao {
    return _expenseDaoInstance ??= _$ExpenseDao(database, changeListener);
  }

  @override
  ManufactureDao get manufactureDao {
    return _manufactureDaoInstance ??=
        _$ManufactureDao(database, changeListener);
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
  Future<int> insertCompany(Company company) {
    return _companyInsertionAdapter.insertAndReturnId(
        company, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertCompanies(List<Company> companies) {
    return _companyInsertionAdapter.insertListAndReturnIds(
        companies, OnConflictStrategy.replace);
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
  Future<int> insertEstimate(Estimate estimate) {
    return _estimateInsertionAdapter.insertAndReturnId(
        estimate, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertEstimates(List<Estimate> estimates) {
    return _estimateInsertionAdapter.insertListAndReturnIds(
        estimates, OnConflictStrategy.replace);
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
  Future<int> insertEstimateResource(EstimateResource estimate) {
    return _estimateResourceInsertionAdapter.insertAndReturnId(
        estimate, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertEstimateResources(List<EstimateResource> estimates) {
    return _estimateResourceInsertionAdapter.insertListAndReturnIds(
        estimates, OnConflictStrategy.replace);
  }
}

class _$ExpenseDao extends ExpenseDao {
  _$ExpenseDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _expenseInsertionAdapter = InsertionAdapter(
            database,
            'Expense',
            (Expense item) => <String, dynamic>{
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
                  'company': item.company,
                  'estimate': item.estimate,
                  'resource': item.resource,
                  'provider': item.provider
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _expenseMapper = (Map<String, dynamic> row) => Expense(
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
      company: row['company'] as int,
      estimate: row['estimate'] as int,
      resource: row['resource'] as int,
      provider: row['provider'] as int);

  final InsertionAdapter<Expense> _expenseInsertionAdapter;

  @override
  Future<List<Expense>> getAllExpenses() async {
    return _queryAdapter.queryList('SELECT * FROM Expense',
        mapper: _expenseMapper);
  }

  @override
  Future<Expense> getExpense(int id) async {
    return _queryAdapter.query('SELECT * FROM Expense Where id = ?',
        arguments: <dynamic>[id], mapper: _expenseMapper);
  }

  @override
  Future<int> insertExpense(Expense expense) {
    return _expenseInsertionAdapter.insertAndReturnId(
        expense, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertExpenses(List<Expense> expenses) {
    return _expenseInsertionAdapter.insertListAndReturnIds(
        expenses, OnConflictStrategy.replace);
  }
}

class _$ManufactureDao extends ManufactureDao {
  _$ManufactureDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _manufactureInsertionAdapter = InsertionAdapter(
            database,
            'Manufacture',
            (Manufacture item) => <String, dynamic>{
                  'id': item.id,
                  'resource': item.resource,
                  'count': item.count,
                  'selfPrice': item.selfPrice,
                  'productTitle': item.productTitle
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  static final _manufactureMapper = (Map<String, dynamic> row) => Manufacture(
      id: row['id'] as int,
      resource: row['resource'] as int,
      count: row['count'] as int,
      selfPrice: row['selfPrice'] as int,
      productTitle: row['productTitle'] as String);

  final InsertionAdapter<Manufacture> _manufactureInsertionAdapter;

  @override
  Future<List<Manufacture>> getAllManufactures() async {
    return _queryAdapter.queryList('SELECT * FROM Manufacture',
        mapper: _manufactureMapper);
  }

  @override
  Future<Manufacture> getManufacture(int id) async {
    return _queryAdapter.query('SELECT * FROM Manufacture Where id = ?',
        arguments: <dynamic>[id], mapper: _manufactureMapper);
  }

  @override
  Future<int> insertManufacture(Manufacture manufacture) {
    return _manufactureInsertionAdapter.insertAndReturnId(
        manufacture, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertManufactures(List<Manufacture> manufactures) {
    return _manufactureInsertionAdapter.insertListAndReturnIds(
        manufactures, OnConflictStrategy.replace);
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
  Future<int> insertProduct(Product product) {
    return _productInsertionAdapter.insertAndReturnId(
        product, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertProducts(List<Product> products) {
    return _productInsertionAdapter.insertListAndReturnIds(
        products, OnConflictStrategy.replace);
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
                  'registerUser': item.registerUser
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
      registerUser: row['registerUser'] as int);

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
  Future<int> insertProvider(Provider provider) {
    return _providerInsertionAdapter.insertAndReturnId(
        provider, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertProviders(List<Provider> providers) {
    return _providerInsertionAdapter.insertListAndReturnIds(
        providers, OnConflictStrategy.replace);
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
  Future<int> insertResource(Resource resource) {
    return _resourceInsertionAdapter.insertAndReturnId(
        resource, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertResources(List<Resource> resources) {
    return _resourceInsertionAdapter.insertListAndReturnIds(
        resources, OnConflictStrategy.replace);
  }
}
