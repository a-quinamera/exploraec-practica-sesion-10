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

En Testing de Antigravity, Run All Tests ejecuta 32 pruebas. El panel cuenta además cuatro operaciones de preparación de las suites y muestra 36/36. Problems debe quedar sin problemas. En Gastos, los chips se calculan a partir de las categorías que tienen gastos; Todas restablece la lista, y el filtro no modifica datos ni hace peticiones HTTP.

El menú de práctica incluye errores provocados a propósito y Acerca de con licencias. Las opciones de fallo solo aparecen en debug. El arranque usa una zona protegida para capturar también errores asíncronos en Flutter Web; el framework, la zona y PlatformDispatcher registran mediante ReporteErrores. Nunca se imprime la excepción sin depurar antes de ocultar Bearer/JWT.

## Repositorio y comprobaciones pendientes

El futuro repositorio debe contener el contenido descomprimido de esta carpeta, con .github en su raíz. Los ZIP son para la plataforma del curso. No subas ZIP, .env, bases locales, credenciales, build ni node_modules a GitHub.

Después de publicar habrá que comprobar CI, comprobar un fallo rojo deliberado y restaurarlo, revisar e integrar el filtro mediante un pull request, crear la etiqueta v1.0.0, comprobar Release APK en verde y descargar/instalar/probar el APK en el emulador Android. Estos resultados aún no existen. Los workflows del curso usan ubuntu-latest en GitHub; el desarrollo local se hizo en Windows.

La configuración .claude/settings.json es material de referencia específico de Claude Code. No aplica permisos a Antigravity. AGENTS.md contiene las reglas propias y las restricciones de trabajo. El workspace activa formatOnSave; no se ha configurado ni afirmado un hook PostToolUse de Claude.
