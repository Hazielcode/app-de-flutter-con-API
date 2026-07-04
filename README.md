# Google Devs Portal - Software Engineering Directory

Este proyecto es un portal corporativo interno desarrollado con **Flutter** para la gestión y administración de perfiles técnicos del equipo de desarrollo de software. Sigue rigurosamente las pautas estéticas de **Google (Material 3)**.

---

## 🎨 Características de Diseño & Interactividad

1. **Sin Rellenos ni Textos Innecesarios:**
   - La interfaz ha sido depurada por completo. Se eliminaron explicaciones largas de bases de datos para dar lugar a una experiencia limpia, ejecutiva y profesional.
2. **Botones Dinámicos Interactivos (`GoogleButton`):**
   - Implementación de un widget de botón personalizado (`GoogleButton`) animado mediante micro-interacciones de escala (`AnimatedScale` y `AnimatedContainer`). Al mantener presionado o dar clic, el botón responde visualmente reduciendo sutilmente su escala (`scale: 0.95`) y cambiando su profundidad, proporcionando feedback dinámico inmediato.
3. **Portal de Ingeniería (Especializado):**
   - El CRUD ahora maneja perfiles de **Desarrolladores/Ingenieros** en lugar de productos básicos.
   - Datos por perfil: Nombre, Rol/Especialidad, Años de experiencia, Tecnologías/Skills, Tarifa Mensual y Bio.
4. **Paleta de Colores de Google y Material 3:**
   - Colores corporativos precisos y tipografía legible (`Roboto`/Sans-serif).
   - Insignias dinámicas de rol basadas en su especialidad.

---

## 📁 Estructura del Código

El código fuente está organizado dentro de `lib/`:

* **[main.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/main.dart):** Inicializador del portal de ingenieros con tema limpio.
* **[shared_styles.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/shared_styles.dart):** Contiene el sistema de diseño (`GoogleColors`), componentes comunes (`GoogleTextField`, `GoogleCard`) y el botón dinámico interactivo con micro-animaciones (`GoogleButton`).
* **[models/developer.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/models/developer.dart):** Modelo de datos del Desarrollador.
* **[database/database_helper.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/database/database_helper.dart):** Controlador Singleton SQLite (móvil/escritorio) y simulador reactivo en memoria (web fallback).
* **[login.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/login.dart):** Login corporativo "Google Developers".
* **[loading_login.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/loading_login.dart):** Animación fluida de inicio de sesión de red.
* **[home.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/home.dart):** Panel y barra de navegación de red.
* **[register_product.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/register_product.dart):** Pantalla de registro de nuevos ingenieros.
* **[product_list.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/product_list.dart):** Directorio de búsqueda y consulta en tiempo real.
* **[edit_product.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/edit_product.dart):** Editor de ficha técnica e inhabilitación de perfiles.
* **[profile.dart](file:///c:/Users/Samir%20Haziel/.gemini/antigravity/scratch/Aplicaciones-Móviles-Multiplataforma/crudcito/lib/profile.dart):** Perfil del administrador.

---

## 🛠️ Cómo Ejecutar el Proyecto

```powershell
flutter run
```
Seleccione Chrome (`2`) o Windows (`1`) para inicializar el portal corporativo.
