import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/estimate.dart';

@dao
abstract class EstimateDao {
  @Query('SELECT * FROM Estimate')
  Future<List<Estimate>> getAllEstimates();

  @Query('SELECT * FROM Estimate Where id = :id')
  Future<Estimate> getEstimate(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertEstimate(Estimate estimate);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertEstimates(List<Estimate> estimates);

  @Query('DELETE FROM Estimate')
  Future<void> deleteAllEstimates();
}