import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:exploraec/controllers/auth_controller.dart';
import 'package:exploraec/controllers/gastos_controller.dart';
import 'package:exploraec/models/gasto.dart';
import 'package:exploraec/models/usuario.dart';
import 'package:exploraec/screens/gastos_screen.dart';
import 'package:exploraec/services/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

class _ServidorSinPeticiones implements HttpClientAdapter {
  int llamadas = 0;
  @override
  Future<ResponseBody> fetch(
    RequestOptions opciones,
    Stream<Uint8List>? cuerpo,
    Future<void>? cancelar,
  ) async {
    llamadas++;
    throw StateError('El filtro no debe consultar al backend');
  }

  @override
  void close({bool force = false}) {}
}

class _SesionDePrueba extends AuthController {
  @override
  Future<void> restaurarSesion() async {}
}

class _GastosDePrueba extends GastosController {
  @override
  Future<void> iniciar() async {}
}

void main() {
  late _ServidorSinPeticiones servidor;
  late GastosController controlador;
  setUp(() {
    Get.reset();
    Get.testMode = true;
    servidor = _ServidorSinPeticiones();
    Get.put(ApiClient(dio: Dio()..httpClientAdapter = servidor));
    final sesion = Get.put<AuthController>(_SesionDePrueba());
    sesion.usuario.value = const Usuario(id: 1, email: 'prueba@example.com');
    controlador = Get.put<GastosController>(_GastosDePrueba());
    controlador.gastos.assignAll(const [
      Gasto(
        id: 1,
        descripcion: 'Almuerzo de prueba',
        monto: 6.5,
        categoria: 'comida',
        fecha: '2026-10-15',
      ),
      Gasto(
        id: 2,
        descripcion: 'Bus de prueba',
        monto: 2,
        categoria: 'transporte',
        fecha: '2026-10-15',
      ),
      Gasto(
        id: 3,
        descripcion: 'Cena de prueba',
        monto: 8,
        categoria: 'comida',
        fecha: '2026-10-15',
      ),
    ]);
    controlador.totalEnServidor.value = 3;
  });
  tearDown(Get.reset);
  testWidgets(
    'Elegir comida muestra solo sus gastos y no consulta al backend',
    (tester) async {
      await tester.pumpWidget(const GetMaterialApp(home: GastosScreen()));
      await tester.tap(find.widgetWithText(ChoiceChip, 'comida'));
      await tester.pumpAndSettle();
      expect(find.text('Almuerzo de prueba'), findsOneWidget);
      expect(find.text('Cena de prueba'), findsOneWidget);
      expect(find.text('Bus de prueba'), findsNothing);
      expect(controlador.gastos.length, 3);
      expect(servidor.llamadas, 0);
    },
  );
  testWidgets('Todas restablece la lista completa después de filtrar', (
    tester,
  ) async {
    await tester.pumpWidget(const GetMaterialApp(home: GastosScreen()));
    await tester.tap(find.widgetWithText(ChoiceChip, 'comida'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Todas'));
    await tester.pumpAndSettle();
    expect(find.text('Almuerzo de prueba'), findsOneWidget);
    expect(find.text('Bus de prueba'), findsOneWidget);
    expect(find.text('Cena de prueba'), findsOneWidget);
    expect(controlador.categoriaActiva, isNull);
    expect(servidor.llamadas, 0);
  });
  testWidgets('El contador sigue comida, transporte y Todas sin pedir datos', (
    tester,
  ) async {
    await tester.pumpWidget(const GetMaterialApp(home: GastosScreen()));
    expect(find.text('Gastos visibles: 3 de 3'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'comida'));
    await tester.pumpAndSettle();
    expect(find.text('Gastos visibles: 2 de 3'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'transporte'));
    await tester.pumpAndSettle();
    expect(find.text('Gastos visibles: 1 de 3'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'Todas'));
    await tester.pumpAndSettle();
    expect(find.text('Gastos visibles: 3 de 3'), findsOneWidget);
    expect(controlador.gastos.length, 3);
    expect(servidor.llamadas, 0);
  });
  test(
    'Si desaparece la categoría elegida, el filtro vuelve a mostrar todas',
    () {
      controlador.filtrarPorCategoria('comida');
      controlador.gastos.removeWhere((g) => g.categoria == 'comida');
      expect(controlador.categoriaActiva, isNull);
      expect(controlador.gastosFiltrados.single.categoria, 'transporte');
      expect(servidor.llamadas, 0);
    },
  );
}
