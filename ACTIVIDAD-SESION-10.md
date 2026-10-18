# Actividad de la sesión 10: calidad, CI/CD y código con agentes

Verificación: 18 de octubre de 2026. Desarrollo en Windows, edición de fuentes exclusivamente en Antigravity y comprobación web en Brave. El proxy del asistente conserva el modo de reglas sin clave elegido por el estudiante. El filtro ya formaba parte de la entrega inicial; esta revisión añade un contador visible y su prueba, integrado mediante el pull request #1.

## Contraste del video con las diapositivas

Se revisó completa la transcripción accesible del reproductor dentro de Brave (598 segmentos, hasta 2:10:18), contrastándola con las 39 diapositivas de `sesion-10.pdf` y el instructivo de práctica. La transcripción automática contiene errores de reconocimiento; los comandos concretos se contrastaron con el código y el instructivo. No se redistribuyen el video ni los materiales docentes.

Video: https://cursos.cedia.org.ec/mod/page/view.php?id=49765

| Tema | Video, aproximadamente | Diapositivas | Aplicación a ExploraEC |
| --- | --- | --- | --- |
| Errores esperados e inesperados | 14:20–20:01 y 1:16–1:22 | 6–9 | Los esperados mantienen su mensaje. FlutterError, PlatformDispatcher y la zona de arranque dirigen los inesperados a ReporteErrores, que limpia los registros. ErrorWidget muestra una vista amistosa. |
| Pruebas y tres estados | 20:11–25:14 y 1:22–1:28 | 10–12 | Pruebas de widgets sin red real; comprobación manual de caché con backend detenido y recuperación al reiniciarlo. |
| Auditoría de secretos | 25:24–29:09 y 1:28–1:33 | 13–15 | Búsqueda de claves y registros inseguros, exclusión de .env e inspección de su historial Git. |
| CI y entrega continua | 29:19–42:37 y 1:33–1:43 | 16–22 | CI analiza y prueba cada push/PR. La rama deliberadamente rota demuestra el rechazo. Release APK vuelve a analizar y probar antes de compilar. |
| Arnés y cambio con agente | 42:53–57:58 y 1:43–1:55 | 23–32 | AGENTS.md con dos reglas propias, cambios pequeños, revisión del diff y pruebas. Antigravity formatea al guardar; .claude es referencia y no configura permisos de Antigravity. |
| Filtro y revisión | 1:49–1:57 | 28–29, 37–38 | Chips locales comida/transporte/Todas, sin llamadas adicionales. Se añadió «Gastos visibles: N de M» para distinguir el subconjunto del total. |
| Versión y APK | 1:57–2:05 | 19–21, 35, 37–38 | La etiqueta v1.0.0 corresponde al código integrado. La validación nativa se mantiene separada de la compilación y de la comprobación en Brave. |

Los números de pruebas mostrados por el docente son una línea base: no se eliminaron pruebas adicionales para igualarlos. La clase usa Ubuntu en Actions; el desarrollo local permanece en Windows. Los hooks específicos de Claude y Acerca de son opcionales. La indicación de compartir pantalla se refiere al desarrollo en vivo del docente, no a un video que deba grabar el estudiante.

## Cambio revisado y pruebas

La lista filtrada no modificaba el encabezado con el total general. Se añadió un contador reactivo en la pantalla de gastos: con tres registros, muestra 2 de 3 para comida, 1 de 3 para transporte y 3 de 3 para Todas. Se calcula con los datos ya cargados, sin dependencias nuevas ni cambios al backend.

Una prueba de widget recorre esas tres selecciones, comprueba los conteos, conserva los tres registros y exige cero consultas al servidor falso. Antigravity también aplicó el formato Dart al guardar los dos archivos.

- Análisis local de lib y test: sin problemas.
- Suite local final: **33 pruebas aprobadas**.
- Compilación web final con el contador: correcta; verificada también en Brave y en el APK del Release.
- Pull request integrado: https://github.com/a-quinamera/exploraec-practica-sesion-10/pull/1 (dos checks aprobados antes de integrar).
- Commit integrado: `6b15757a86301d6d82419af6f89b4c14116cbfc0`.

## CI verde y fallo rojo entendido

CI verde de referencia: https://github.com/a-quinamera/exploraec-practica-sesion-10/actions/runs/38992895691

Demostración roja: https://github.com/a-quinamera/exploraec-practica-sesion-10/actions/runs/39154336720

En una rama aislada se cambió el dato de la prueba de contraseña corta de tres a ocho caracteres. La aplicación aceptó esa longitud y no mostró el mensaje reservado a contraseñas cortas; la expectativa quedó deliberadamente incumplida. La prueba dirigida falló también en local. En Actions, el paso Ejecutar las pruebas terminó con **31 aprobadas y 1 fallida**, identificando ese mismo caso. No se desactivaron pruebas ni se integró el dato roto en main.

La rama remota de demostración se eliminó con autorización del estudiante después de conservar la evidencia. La ejecución roja, el commit y la copia local siguen disponibles; main conserva el código correcto.

## Comprobación real en Brave

Se utilizó una cuenta local de pruebas con seis gastos ficticios, sin modificar cuentas ajenas. El contador final mostró 6 de 6, 2 de 6 para comida, 1 de 6 para transporte y nuevamente 6 de 6 en Todas. El fallo de widget mostró «Esta pantalla tuvo un problema», sin traza técnica, y el regreso permitió continuar. También se abrió Acerca de y su lista de licencias.

Se detuvo únicamente gastos-backend desde Docker Desktop. /health dejó de responder y Recargar mantuvo la lista con el aviso «Sin conexión — gastos guardados». Al reiniciar el mismo contenedor, /health volvió a indicar status/db ok y Reintentar recuperó la lista sin el aviso de caché. El backend quedó encendido.

El fallo asíncrono se registró en el mismo canal central como un mensaje limpio de StateError. No se alcanzó a observar el snackbar en las capturas iniciales; esa observación no se presenta como verificada. No se publican contraseñas, JWT ni la base de datos de la cuenta de prueba.

## Auditoría de publicación

Se revisaron 52 archivos de fuentes, pruebas, workflows y contexto. No hubo coincidencias de claves reales con los patrones auditados ni impresiones directas de token/Bearer. .env está ignorado en la raíz, Flutter y backend, y no aparece en el historial Git. El backend conserva únicamente .env.example como plantilla. No se leyeron los archivos .env.

Las pruebas incluyen la limpieza de Bearer/JWT y una regresión que evita imprimir la excepción sin depurar desde FlutterError. Esta auditoría por patrones no equivale a una certificación exhaustiva de seguridad.

## Respuestas a las dinámicas

1. El registro Authorization: Bearer no debe guardarse: permitiría usar la sesión. El correo también debe omitirse salvo necesidad concreta; «fallo al cargar gastos» es un mensaje genérico adecuado.
2. Borrar una clave publicada no la vuelve segura. Se revoca o rota en el proveedor y luego se trata el historial; nunca se supone secreta solo porque desapareció del último commit.
3. Antes de aceptar código de una persona o de un agente se revisa el diff, se comprueba el alcance, se auditan secretos y se ejecutan análisis y pruebas. La CI aporta una verificación independiente.
4. Para demostrar persistencia local se muestran datos ya cargados con el backend detenido, el aviso de caché y la recuperación posterior; es evidencia observable, no solo una afirmación.

## Release y comprobación nativa

Compilación manual correcta: https://github.com/a-quinamera/exploraec-practica-sesion-10/actions/runs/39154125675 . Generó el artefacto exploraec-apk; al ser workflow_dispatch, no creó un Release. Este resultado corresponde a la base previa al contador y no sustituye la publicación etiquetada del código integrado.

La ejecución etiquetada terminó correctamente: https://github.com/a-quinamera/exploraec-practica-sesion-10/actions/runs/39160341215 . Actions analizó, probó, compiló y publicó el APK del commit integrado `6b15757` en https://github.com/a-quinamera/exploraec-practica-sesion-10/releases/tag/v1.0.0 . Los commits posteriores de main documentan sus resultados; no cambian el código de ese APK.

Se descargó `app-release.apk` (53,7 MB) y su SHA-256 coincidió con el digest publicado: `4b2a2294fb0924cb51edb4841f91c74da8aa72229aae529339e62770bbe643fc`. ADB confirmó la instalación de `com.example.exploraec`, versión 1.0.0, sin la bandera DEBUGGABLE. Se abrió el APK y se comprobó la conexión con el backend real en `http://10.0.2.2:8000`, usando gastos ficticios. Las capturas y el informe de paquete están en `Evidencias/Validacion-2026-10-18`.

El inicio del emulador por consola había fallado con 0x80070005. Finalmente arrancó mediante Flutter: Launch Emulator en Antigravity, sin cambiar la seguridad de Windows. El estudiante completó la escritura del inicio de sesión porque el emulador no recibía texto del control automático.

## Qué se entrega en Moodle

En el video, aproximadamente 1:01:54–1:03:19, el docente aclara que se pega **el enlace al repositorio**, tanto en prácticas como en el proyecto final. Un Word con ese enlace es alternativa si Moodle no permite pegar texto. No exige un informe separado ni una grabación del estudiante. El repositorio debe contener las fuentes y la evidencia necesaria para ejecutar y evaluar la actividad, incluido el Release con APK cuando se complete su validación.

No se ha enviado ni marcado ninguna entrega en Moodle desde esta actividad.
