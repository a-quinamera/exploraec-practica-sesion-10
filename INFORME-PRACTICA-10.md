# Estado de la práctica 10

Publicación del código autorizada el 16 de octubre de 2026.

Verificado durante el desarrollo: 32 pruebas Flutter aprobadas (36/36 en Antigravity al incluir cuatro operaciones de preparación), analizador del IDE sin problemas, filtros comida/transporte/Todas con el backend real y pantalla de error amistosa con regreso a la lista. Las pruebas incluyen una regresión para comprobar que FlutterError no imprima el Bearer sin depurar.

Se agregó una zona protegida en main para capturar errores asíncronos también en Flutter Web. Quedó pendiente su última comprobación manual en Brave y la comprobación de desconexión/recuperación del backend, porque el control del navegador se detuvo. No se presentan como verificadas.

Los workflows CI y Release APK se incluyen en la raíz del repositorio y usan la carpeta Flutter anidada. Esta publicación no afirma que Actions haya pasado, que exista el Release v1.0.0 ni que el APK se haya instalado en Android. El ejercicio de CI roja, el pull request y la validación del APK siguen pendientes.

El workspace formatea al guardar. La configuración de Claude incluida es material del curso; no configura los permisos de Antigravity ni implica un hook activo de Claude.
