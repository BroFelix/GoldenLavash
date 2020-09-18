import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/company.dart';

@dao
abstract class CompanyDao{
  @Query('SELECT * FROM Company')
  Future<List<Company>> getAllCompanies();

  @Query('SELECT * FROM Company Where id = :id')
  Future<Company> getCompany(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertCompany(Company company);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertCompanies(List<Company> companies);

  @Query('DELETE FROM Company')
  Future<void> deleteAllCompanies();
}