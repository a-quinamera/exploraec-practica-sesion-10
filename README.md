# Práctica 10 — ExploraEC

Desarrollo local en Windows con Antigravity y pruebas en Brave. El asistente conserva el modo de reglas, sin clave de IA. Publicación del código autorizada el 16 de octubre de 2026. Consulta INFORME-PRACTICA-10.md para distinguir las comprobaciones terminadas de las pendientes.

## Contenido

- Sesion-10.code-workspace: abre la app y el backend en Antigravity.
- exploraec-curso/exploraec: aplicación Flutter, pruebas, proxy Node y recursos del curso.
- exploraec-curso/proyecto-curso-spec-kit: backend FastAPI, migraciones y Docker Compose.
- .github/workflows: CI y generación/publicación del APK, adaptados a esta estructura de carpetas.
- INFORME-PRACTICA-10.md y Evidencias: verificación y pendientes de entrega.

## Ejecutar en Windows

Requisitos: Flutter y su SDK de Dart, Node.js, Docker Desktop con el motor iniciado, Brave y Antigravity. La comprobación local usó Flutter 3.44.1 y Dart 3.12.1.

1. Abre Sesion-10.code-workspace en Antigravity.
2. Si ya tienes el backend del curso funcionando en localhost:8000, reutilízalo. No inicies dos copias en el mismo puerto. Para una instalación limpia, entra en exploraec-curso/proyecto-curso-spec-kit, copia tú .env.example a .env y completa SECRET_KEY con un valor aleatorio propio; no lo publiques. Ejecuta docker compose up --build -d en una terminal de Antigravity. Verifica http://localhost:8000/health. Los contenedores locales conservan sus datos en el volumen de Docker.
3. En la carpeta exploraec-curso/exploraec, ejecuta Flutter: Get Packages desde la paleta de Antigravity. Si instalas el proxy por primera vez, ejecuta npm ci desde su subcarpeta mock-server en una terminal de Antigravity.
4. En Run and Debug inicia Proxy ExploraIA - Reglas. No requiere GEMINI_API_KEY.
5. Selecciona ExploraEC - Sesion 10 (Brave) e iníciala con el botón verde del panel. Abre http://localhost:8186/ en Brave. El proxy escucha en localhost:3000 y el backend en localhost:8000.
6. Inicia sesión con una cuenta del backend local. Las cuentas y contraseñas de verificación no forman parte de la entrega. Una instalación limpia necesita registrar su propia cuenta.

Comandos equivalentes desde la carpeta Flutter, dentro de una terminal de Antigravity:

    flutter pub get
    flutter analyze
    flutter test
    flutter run -d web-server --web-port 8186 --dart-define=API_BASE_URL=http://localhost:8000 --dart-define=LLM_BACKEND_URL=http://localhost:3000

Si cambias main(), detén y vuelve a iniciar Flutter. Un hot reload no vuelve a ejecutar main. Una compilación web inicial puede tardar; recarga Brave cuando el servidor ya haya terminado.

## Comprobaciones

En Testing de Antigravity, Run All Tests ejecuta la suite. La verificación actual por consola aprobó 34 pruebas; el panel puede contar también operaciones de preparación. Problems debe quedar sin problemas. En Gastos, los chips se calculan a partir de las categorías que tienen gastos; Todas restablece la lista, y el filtro no modifica datos ni hace peticiones HTTP.

El menú de práctica incluye errores provocados a propósito y Acerca de con licencias. Las opciones de fallo solo aparecen en debug. El arranque usa una zona protegida para capturar también errores asíncronos en Flutter Web; el framework, la zona y PlatformDispatcher registran mediante ReporteErrores. Nunca se imprime la excepción sin depurar antes de ocultar Bearer/JWT.

## Actividad contrastada con la grabación

[Informe de la actividad](ACTIVIDAD-SESION-10.md): comparación con las diapositivas, respuestas a las dinámicas, auditoría y evidencias de CI verde/roja y del backend real. La mejora del contador del filtro se integró mediante el [PR #1](https://github.com/a-quinamera/exploraec-practica-sesion-10/pull/1). Se verificaron 34 tests y análisis sin problemas.

El repositorio contiene fuentes descomprimidas y .github en su raíz. No se publican ZIP, .env, bases locales, credenciales, build ni node_modules. El [Release v1.0.0 con APK](https://github.com/a-quinamera/exploraec-practica-sesion-10/releases/tag/v1.0.0) se generó desde el código integrado. Se verificó su SHA-256, instalación y funcionamiento de gastos y filtros en Android contra el backend real. Consulta el informe para las evidencias y el alcance de cada comprobación.

Para ejecutar el APK en el emulador Android, el backend debe estar activo en el PC: `10.0.2.2:8000` apunta al host. En un teléfono físico se debe compilar con la dirección accesible del servidor; localhost del teléfono no es el PC. El APK del curso utiliza la firma de desarrollo del workflow y no es una publicación en Google Play.

La configuración .claude/settings.json es referencia de Claude Code y no configura los permisos de Antigravity. AGENTS.md incluye las reglas propias; el workspace activa formatOnSave. El desarrollo local se realizó en Windows y los workflows usan Ubuntu remoto en GitHub Actions.
