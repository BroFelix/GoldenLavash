import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/resource.dart';

@dao
abstract class ResourceDao {
  @Query('SELECT * FROM Resource')
  Future<List<Resource>> getAllResources();

  @Query('SELECT * FROM Resource Where id = :id')
  Future<Resource> getResource(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertResource(Resource resource);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertResources(List<Resource> resources);

  @Query('DELETE FROM Resource')
  Future<void> deleteAllResources();
}
