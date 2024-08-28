import 'package:control_stock/data/datasource/api/notaentrada/note_entry_client.dart';
import 'package:control_stock/domain/entitites/entrynote.dart';
import 'package:control_stock/domain/entitites/product.dart';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/data/datasource/api/producto/product_client.dart';

NoteEntryClient api = NoteEntryClient();
AppColor StyleApp = AppColor();

class EntryNoteViewModel {
  Future<List<Map<String, dynamic>>> listNotaEntrada(String query) {
    Future<List<Map<String, dynamic>>> productos =
        api.listarNotasEntrada(query);
    return productos;
  }

  AddNotaEntrada(NotaEntrada data) {
    Future<bool> notaentrada = api.AgregarNotaEntrada(data);
    return notaentrada;
  }

  EditProducto(Product producto) {}
}
