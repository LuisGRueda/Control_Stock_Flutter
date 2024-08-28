import 'package:control_stock/domain/entitites/product.dart';

abstract class NoteEntryClientRepository {
  Future<List<Product>> _searchNoteEntry(String query);
  Future<bool> AgregarNotaEntrada(data);
  Future<bool> EditarNotaEntrada(data);
}
