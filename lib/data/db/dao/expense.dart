import 'package:floor/floor.dart';
import 'package:golden_app/data/db/model/expense.dart';

@dao
abstract class ExpenseDao {
  @Query('SELECT * FROM Expense')
  Future<List<Expense>> getAllExpenses();

  @Query('SELECT * FROM Expense Where id = :id')
  Future<Expense> getExpense(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertExpense(Expense expense);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<List<int>> insertExpenses(List<Expense> expenses);
}