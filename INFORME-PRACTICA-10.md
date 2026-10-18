# Estado de la práctica 10

Actualizado el 18 de octubre de 2026. El contraste de la transcripción completa, las 39 diapositivas, los resultados y sus límites está en [ACTIVIDAD-SESION-10.md](ACTIVIDAD-SESION-10.md).

Comprobado: 33 pruebas locales aprobadas, análisis sin problemas, PR #1 integrado con sus dos checks en verde, CI roja deliberada entendida (31 pasan y una falla), caché y recuperación contra el backend real, filtros comida/transporte/Todas y registro limpio de errores. El filtro incorpora un contador de gastos visibles, con prueba de widget sin peticiones al servidor.

El [Release v1.0.0](https://github.com/a-quinamera/exploraec-practica-sesion-10/releases/tag/v1.0.0) fue publicado automáticamente por Actions desde el código integrado. Su APK se descargó, se verificó por SHA-256 y se instaló en Android. La app abrió y cargó los seis gastos ficticios del backend real; los filtros comida y transporte mostraron dos y un registro respectivamente. Las evidencias incluyen el paquete Android 1.0.0 sin DEBUGGABLE y las capturas.

La rama remota de prueba roja se eliminó con autorización; la ejecución fallida y su copia local se conservaron. El snackbar asíncrono no se presenta como observado: se verificó su registro central limpio, además de la vista de error de widget y la recuperación de caché. No se publican credenciales ni archivos .env.
