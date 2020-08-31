import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/manufacture.dart';

@dao
abstract class ManufactureDao {
  @Query('SELECT * FROM Manufacture')
  Future<List<Manufacture>> getAllManufactures();

  @Query('SELECT * FROM Manufacture Where id = :id')
  Future<Manufacture> getManufacture(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertManufacture(Manufacture manufacture);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertManufactures(List<Manufacture> manufactures);
}