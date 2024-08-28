import 'package:control_stock/data/datasource/api/areauso/usearea_client.dart';
import 'package:control_stock/data/datasource/api/factory/factory_client.dart';
import 'package:control_stock/data/datasource/api/modelo/model_client.dart';
import 'package:control_stock/data/datasource/api/notaentrada/note_entry_client.dart';
import 'package:control_stock/data/datasource/api/producto/product_client.dart';
import 'package:control_stock/data/datasource/api/tiponota/tiponota_client.dart';
import 'package:control_stock/data/datasource/api/almacen/almacen_client.dart';

//CREANDO OBJETOS DE LOS MODELOS DE API
NoteEntryClient api = NoteEntryClient();
TipoNotaClient apiTipoNota = TipoNotaClient();
AlmacenClient apiAlmacen = AlmacenClient();
FactoryClient apiFabrica = FactoryClient();
ModelClient apiModelo = ModelClient();
UseAreaClient apiUseArea = UseAreaClient();
ProductoClient apiProducto = ProductoClient();

class CrudEntryNoteViewModel {
  // LLAMANDO A LA FUNCION DEL API BUSCAR EntryNoteO
  Future<List<Map<String, dynamic>>> searchEntryNotes(String params) {
    Future<List<Map<String, dynamic>>> EntryNoteos =
        api.listarNotasEntrada(params);
    return EntryNoteos;
  }

  // ignore: non_constant_identifier_names

  //LLAMANDO A LA FUNCION DE AGREGAR DEL API
  Future<bool> AddNotaEntrada(data) async {
    return api.AgregarNotaEntrada(data);
  }

  //LLAMANDO A LA FUNCION DE EDITAR DEL API
  Future<bool> EditNotaEntrada(data) async {
    return api.EditarNotaEntrada(data);
  }

  Future<Map<String, dynamic>> NotaEntradaId(String id) {
    Future<Map<String, dynamic>> EntryNoteos = api.NotaEntradaId(id);
    return EntryNoteos;
  }

  //LLAMANDO A LA FUNCION DEL API DE LISTAR TIPOS DE Notas
  Future<List<Map<String, dynamic>>> ListTipoNota() {
    Future<List<Map<String, dynamic>>> EntryNoteos = apiTipoNota.listTipoNota();
    return EntryNoteos;
  }

  //LLAMANDO A LA FUNCION DEL API DE LISTAR ALMACEN
  Future<List<Map<String, dynamic>>> ListAlmacen() {
    Future<List<Map<String, dynamic>>> almacen = apiAlmacen.listAlmacen();
    return almacen;
  }

  // LLAMANDO A LA FUNCION DEL API BUSCAR CATEGORIA
  Future<List<Map<String, dynamic>>> buscarProductoNota(String params) {
    Future<List<Map<String, dynamic>>> productos =
        apiProducto.buscarProductoNota(params);
    return productos;
  }

  // LLAMANDO A LA FUNCION DEL API BUSCAR FABRICANTE
  Future<List<Map<String, dynamic>>> searchFactorys(String params) {
    Future<List<Map<String, dynamic>>> fabrica =
        apiFabrica.searchFactory(params);
    return fabrica;
  }
}/*


// LLAMANDO A LA FUNCION DEL API BUSCAR FABRICANTE
  Future<List<Map<String, dynamic>>> searchFactorys(String params) {
    Future<List<Map<String, dynamic>>> fabrica =
        apiFabrica.searchFactory(params);
    return fabrica;
  }

// LLAMANDO A LA FUNCION DEL API BUSCAR UNIDADES DE MEDIDA
  Future<List<Map<String, dynamic>>> listarUnidadMedida(String params) {
    Future<List<Map<String, dynamic>>> unidadMedida =
        apiMedida.listarUnidadMedida(params);
    return unidadMedida;
  }





//LLAMANDO A LA FUNCION DEL API DE LISTAR MODELOS
  Future<List<Map<String, dynamic>>> ListModel() {
    Future<List<Map<String, dynamic>>> EntryNoteos = apiModelo.listModel();
    return EntryNoteos;
  }


}*/
