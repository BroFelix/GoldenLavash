import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/estimate_resource.dart';

@dao
abstract class EstimateResourceDao {
  @Query('SELECT * FROM EstimateResource')
  Future<List<EstimateResource>> getAllEstimateResources();

  @Query('SELECT * FROM EstimateResource Where id = :id')
  Future<EstimateResource> getEstimateResource(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertEstimateResource(EstimateResource estimate);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertEstimateResources(
      List<EstimateResource> estimateResources);

  @Query('DELETE FROM EstimateResource')
  Future<void> deleteAllEstimateResources();

  @transaction
  Future<void> replaceEstimateResources(
      List<EstimateResource> estimateResources) async {
    await deleteAllEstimateResources();
    await insertEstimateResources(estimateResources);
  }
}
