\# Proyecto Final - Desarrollo Web y Móvil 📱💻



Este proyecto corresponde al \*\*trabajo final de la materia de Desarrollo Móvil\*\*, implementando una \*\*API en .NET\*\* y una \*\*aplicación en Flutter\*\* que se comunican entre sí para realizar un CRUD de productos de tecnología.



---



\## 📂 Estructura del proyecto



proyectofinalmovil/

├─ backend/ # API en .NET 6/7 (ProductApi.sln, controladores, modelos)

├─ frontend/ # App Flutter (lib/, pubspec.yaml, páginas, providers)

├─ README.md # 

├─ .gitignore



---



\## 🚀 Tecnologías utilizadas



\- \*\*Backend\*\*

&nbsp; - ASP.NET Core 6/7

&nbsp; - Swagger (documentación interactiva)

&nbsp; - CORS habilitado para desarrollo



\- \*\*Frontend\*\*

&nbsp; - Flutter 3

&nbsp; - Provider (gestión de estado)

&nbsp; - HTTP package (consumo de API REST)



---



\## ⚙️ Instalación y ejecución



\### 1️⃣ Backend (API en .NET)



1\. Abrir una terminal en la carpeta `backend/`.

2\. Restaurar dependencias:



&nbsp;	```bash

&nbsp;  		dotnet restore



3.Ejecutar la API:



&nbsp;	dotnet run 



4\. Swagger disponible en:

👉 http://localhost:7059/swagger/index.html



---

2️⃣ Frontend (Flutter)



1. Abrir una terminal en la carpeta frontend/.



2\. Instalar dependencias:



flutter pub get



3\. Ejecutar la app en web (Chrome):



flutter run -d chrome --web-hostname localhost --web-port 7357



4\. Según el entorno, la base URL de la API debe configurarse en lib/env.dart:



* Web/desktop → http://localhost:7059
* Android emulator → http://10.0.2.2:7059
* iOS simulator → http://localhost:7059



---



📡 Endpoints principales (API)



* GET /Product/GetProducts → Lista todos los productos.
* GET /Product/GetProductsByParameter → Busca productos por nombre, categoría o precio.
* POST /Product/CreateProduct → Crea un producto.
* POST /Product/UpdateProduct → Actualiza un producto.
* POST /Product/DeleteProduct → Elimina un producto (requiere id en headers).



--- 



🛠️ Funcionalidades implementadas en la App Flutter



* Splash Page con logo personalizado.
* Listado de productos con buscador.
* Detalle del producto (precio, descripción, categoría).
* Crear producto (formulario).
* Editar producto (con validación de campos).
* Eliminar producto con confirmación.
* Manejo de errores y notificaciones (SnackBar).



---



👨‍💻 Autor



Nombre: Johan Guerrero

Materia: Desarrollo Móvil 

Proyecto final — Flutter + .NET



---



📜 Licencia



Este proyecto es únicamente con fines académicos.

Se prohíbe su distribución con fines comerciales sin autorización del autor.

