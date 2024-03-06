## Pokédex App

### Descripción

Esta aplicación iOS implementa una Pokédex que muestra información sobre los primeros 151 Pokémon. Se utiliza la API [PokeAPI](https://pokeapi.co/) para obtener datos sobre los Pokémon, y las imágenes son obtenidas de [PokeAPI Sprites](https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/{id-pokemon}.png).

### Características

1. **Listado de Pokémon:**
   - Al iniciar la aplicación, se descargan y muestran los primeros 151 Pokémon.
   - Se proporciona una barra de búsqueda para buscar Pokémon por nombre.

2. **Detalle de Pokémon:**
   - Al seleccionar un Pokémon del listado, se muestra una vista detallada con la información sobre el tipo, evoluciones y ataques del Pokémon.

### Tecnologías Utilizadas

- Swift
- Swift Package Manager (SPM)
- [SDWebImage](https://github.com/SDWebImage/SDWebImage) para la carga de imágenes.

### Instalación

1. Clona este repositorio en tu máquina local.

   ```bash
   git clone git@github.com:OscarSierra14/Pokemons.git
   ```

2. Abre el proyecto en Xcode.

   ```bash
   cd Pokemons
   open Pokemons.xcodeproj
   ```

3. Construye y ejecuta la aplicación en el simulador de iOS.

### Configuración del Proyecto

Este proyecto utiliza Swift Package Manager para gestionar las dependencias. Al clonar el repositorio, las dependencias deberían resolverse automáticamente. En caso de algún problema, asegúrate de que el archivo `Package.swift` esté configurado correctamente.

### Estructura del Proyecto

- **PokémonList:** Contiene la implementación de la vista de lista de Pokémon.
- **PokemonDetail:** Contiene la implementación de la vista de detalle de Pokémon.
- **API:** Contiene las clases y estructuras relacionadas con la interacción con la API de Pokémon.
- **Utilities:** Contiene utilidades generales utilizadas en el proyecto.
- **Resources:** Almacena los recursos estáticos como imágenes.

### Autor

Oscar Sierra
