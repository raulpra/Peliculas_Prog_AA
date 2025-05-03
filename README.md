# Peliculas_Prog_AA
Actividad de aprendizaje 2ª Ev Programación

# 🎬 Aplicación Web de Gestión de Películas y Usuarios
---
## 🧩 Descripción General

Este proyecto es una aplicación web desarrollada con **Java (JSP/Servlets)** y **MySQL/MariaDB**, diseñada para la **gestión de películas, usuarios, géneros y favoritos**. La aplicación implementa control de acceso basado en roles (Administrador y Usuario), e incluye operaciones CRUD completas para las siguientes tablas: películas, usuarios y géneros. 

La base de datos se encuentra en un contenedor Docker y el proyecto se despliega en el puerto `8082`.

---

## 🔄 Flujo de Funcionamiento

1. El usuario accede como visitante o inicia sesión.
2. Según su rol, se habilitan diferentes funciones en la navegación.
3. Se utilizan formularios validados con AJAX.
4. Toda la información se guarda y consulta en la base de datos.
5. La Seguridad y visibilidad de datos se controlan con sesiones y roles.

---

## 🔐 Accesos y Roles 
### Accesos:
- Control de acceso por sesión (`HttpSession`).
- Validaciones en servidor y cliente.
- Restricciones según rol en vistas y servlets.

### Roles:
### 1. Usuario sin iniciar sesión
- Puede ver el listado general de películas y géneros.
- No tiene permisos para modificar datos ni realizar acciones personalizadas.

### 2. Usuario registrado (`usuario`)
- Puede iniciar sesión con su cuenta.
- Accede a su lista de películas favoritas.
- Puede agregar o eliminar películas a favoritos desde la lista general.
- Puede editar parcialmente su perfil (sin modificar su rol, estado ni email).

### 3. Administrador (`admin`)
- Tiene acceso a:
  - Gestión de películas, puede crear, eliminar, modificar y actualizar.
  - Gestión de géneros  puede crear, eliminar, modificar y actualizar.
  - Gestión de usuarios  puede crear, eliminar, modificar y actualizar.
- Visualiza el detalle completo de cualquier usuario.
- Modifica rol, estado y valoración de los usuarios.

---

## ⚙️ Tecnologías Utilizadas

- **Backend**:
  - Java (Servlets, JSP)
  - JDBC + Patron DAO
- **Frontend**:
  - HTML5, Bootstrap 5
  - JavaScript, jQuery, AJAX
- **Base de Datos**:
  - MySQL / MariaDB (en contenedor Docker)
  - Tablas: `usuarios`, `peliculas`, `generos`, `favoritos`

---

## 🧑‍💻 Autor

> Proyecto desarrollado por Raúl Prada Devesa
