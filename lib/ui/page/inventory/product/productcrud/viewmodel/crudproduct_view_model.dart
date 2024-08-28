import 'package:control_stock/data/datasource/api/areauso/usearea_client.dart';
import 'package:control_stock/data/datasource/api/categoria/category_client.dart';
import 'package:control_stock/data/datasource/api/factory/factory_client.dart';
import 'package:control_stock/data/datasource/api/modelo/model_client.dart';
import 'package:control_stock/data/datasource/api/producto/product_client.dart';
import 'package:control_stock/data/datasource/api/umedida/umedida_client.dart';
import 'package:control_stock/data/datasource/api/pruductType/productType_client.dart';

//CREANDO OBJETOS DE LOS MODELOS DE API
ProductoClient api = ProductoClient();
UnidadMedidaClient apiMedida = UnidadMedidaClient();
CategoryClient apiCategoria = CategoryClient();
ProductTypeClient apiProductoTipo = ProductTypeClient();
FactoryClient apiFabrica = FactoryClient();
ModelClient apiModelo = ModelClient();
UseAreaClient apiUseArea = UseAreaClient();

class CrudProductViewModel {
  // LLAMANDO A LA FUNCION DEL API BUSCAR PRODUCTO
  Future<List<Map<String, dynamic>>> searchProducts(String params) {
    Future<List<Map<String, dynamic>>> productos = api.listarProductos(params);
    return productos;
  }

  // ignore: non_constant_identifier_names

  //LLAMANDO A LA FUNCION DE AGREGAR DEL API
  Future<bool> AddProduct(data) async {
    return api.AddProduct(data);
  }

  //LLAMANDO A LA FUNCION DE EDITAR DEL API
  Future<bool> EditProduct(data) async {
    return api.ModifyProducto(data);
  }

// LLAMANDO A LA FUNCION DEL API BUSCAR CATEGORIA
  Future<List<Map<String, dynamic>>> searchCategorys(String params) {
    Future<List<Map<String, dynamic>>> categorias =
        apiCategoria.searchCategory(params);
    return categorias;
  }

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

//LLAMANDO A LA FUNCION DEL API DE LISTAR TIPOS DE PRODUCTOS
  Future<List<Map<String, dynamic>>> ListProductType() {
    Future<List<Map<String, dynamic>>> productos =
        apiProductoTipo.listProdcutType();
    return productos;
  }

//LLAMANDO A LA FUNCION DEL API DE LISTAR AREA DE USO
  Future<List<Map<String, dynamic>>> ListAreaUso() {
    Future<List<Map<String, dynamic>>> areauso = apiUseArea.searchUseArea();
    return areauso;
  }

//LLAMANDO A LA FUNCION DEL API DE LISTAR MODELOS
  Future<List<Map<String, dynamic>>> ListModel() {
    Future<List<Map<String, dynamic>>> productos = apiModelo.listModel();
    return productos;
  }

  Future<Map<String, dynamic>> ProductoId(String id) {
    Future<Map<String, dynamic>> productos = api.fetchProduct(id);
    return productos;
  }
}
