import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/provider.dart';

@dao
abstract class ProviderDao {
  @Query('SELECT * FROM Provider')
  Future<List<Provider>> getAllProviders();

  @Query('SELECT * FROM Provider Where id = :id')
  Future<Provider> getProvider(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertProvider(Provider provider);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertProviders(List<Provider> providers);

  @Query('DELETE FROM Provider')
  Future<void> deleteAllProviders();

  @transaction
  Future<void> replaceProviders(List<Provider> providers) async {
    await deleteAllProviders();
    await insertProviders(providers);
  }
}
