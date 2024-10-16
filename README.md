# Proyecto Flutter "Duel Yu-Gi-Oh!"

![Captura de pantalla de la aplicación Duel Yu-Gi-Oh!](https://i.imgur.com/4hkXUm9.jpeg)

## Descripción
Este proyecto es una aplicación móvil desarrollada con Flutter que permite a los usuarios explorar y buscar cartas del popular juego de cartas Yu-Gi-Oh!. La aplicación consume datos de una API de Yu-Gi-Oh! y utiliza el patrón BLoC para la gestión del estado, ofreciendo una experiencia de usuario fluida y eficiente.

## Requisitos
- Flutter 3.24.3
- Dart 3.5.3
- DevTools 2.37.3
- Dispositivo móvil con S.O. (Android/iOS)

## Instalación
1. Clona este repositorio en tu máquina local.
    ```bash
    git clone https://github.com/tu-usuario/duel-yu-gi-oh.git
    ```
2. Accede al directorio del proyecto.
    ```bash
    cd duel-yu-gi-oh
    ```
3. Instala las dependencias.
    ```bash
    flutter pub get
    ```
4. Ejecuta el proyecto en tu dispositivo o en un emulador.
    ```bash
    flutter run
    ```

## Uso
Una vez que la aplicación esté en ejecución, podrás:
- Explorar una lista de cartas de Yu-Gi-Oh!
- Buscar cartas por arquetipo
- Ver detalles de las cartas seleccionadas
- Disfrutar de una interfaz de usuario intuitiva y atractiva

## Estructura del proyecto
El proyecto sigue una arquitectura limpia:
- `lib/`
  - `app.dart`: Configuración principal de la aplicación
  - `main.dart`: Punto de entrada de la aplicación
  - `colors/`: Definiciones de colores
  - `core/`: Utilidades y configuraciones centrales
  - `data/`: Implementaciones de repositorios y fuentes de datos
  - `domain/`: Entidades, casos de uso y definiciones de repositorios
  - `presentation/`: Widgets, páginas y lógica de presentación (BLoC)

## Dependencias principales
- `equatable`: Para comparaciones de objetos simplificadas
- `http`: Para realizar solicitudes HTTP
- `bloc`: Para la gestión del estado
- `mockito`: Para crear mocks en las pruebas

## Contribución
¡Las contribuciones son bienvenidas! Si deseas mejorar este proyecto, no dudes en abrir un PR.

## Licencia
Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.
