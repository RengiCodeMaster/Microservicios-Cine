# Microservicios-Cine

Sistema de gestión de cine basado en microservicios usando Spring Boot y Spring Cloud.

## 📋 Descripción

Este proyecto implementa un sistema completo de gestión para un cine utilizando arquitectura de microservicios. El sistema permite gestionar películas, reservas de boletos y usuarios.

## 🏗️ Arquitectura

El sistema está compuesto por los siguientes microservicios:

- **Eureka Server** (Puerto 8761): Servidor de descubrimiento de servicios
- **API Gateway** (Puerto 8080): Punto de entrada único para todas las peticiones
- **Movie Service** (Puerto 8081): Gestión de películas
- **Booking Service** (Puerto 8082): Gestión de reservas de boletos
- **User Service** (Puerto 8083): Gestión de usuarios

## 🚀 Tecnologías Utilizadas

- Java 17
- Spring Boot 3.1.5
- Spring Cloud 2022.0.4
- Spring Data JPA
- H2 Database (en memoria)
- Eureka Server (Service Discovery)
- Spring Cloud Gateway
- Lombok
- Maven
- Docker & Docker Compose

## 📦 Requisitos Previos

- JDK 17 o superior
- Maven 3.6+
- Docker y Docker Compose (opcional, para despliegue con contenedores)

## 🔧 Instalación y Ejecución

### Opción 1: Ejecución con Maven

1. Clonar el repositorio:
```bash
git clone https://github.com/RengiCodeMaster/Microservicios-Cine.git
cd Microservicios-Cine
```

2. Compilar todos los microservicios:
```bash
mvn clean install
```

3. Iniciar los servicios en el siguiente orden:

   a. Eureka Server:
   ```bash
   cd eureka-server
   mvn spring-boot:run
   ```

   b. API Gateway (en otra terminal):
   ```bash
   cd api-gateway
   mvn spring-boot:run
   ```

   c. Movie Service (en otra terminal):
   ```bash
   cd movie-service
   mvn spring-boot:run
   ```

   d. Booking Service (en otra terminal):
   ```bash
   cd booking-service
   mvn spring-boot:run
   ```

   e. User Service (en otra terminal):
   ```bash
   cd user-service
   mvn spring-boot:run
   ```

### Opción 2: Ejecución con Docker Compose

1. Compilar los microservicios:
```bash
mvn clean package -DskipTests
```

2. Iniciar todos los servicios con Docker Compose:
```bash
docker-compose up -d
```

3. Para detener los servicios:
```bash
docker-compose down
```

## 🔗 Endpoints

### Eureka Dashboard
- URL: http://localhost:8761

### API Gateway
Todas las peticiones deben ir a través del API Gateway en `http://localhost:8080`

### Movie Service
- `GET /api/movies` - Obtener todas las películas
- `GET /api/movies/{id}` - Obtener película por ID
- `GET /api/movies/genre/{genre}` - Obtener películas por género
- `GET /api/movies/search?title={title}` - Buscar películas por título
- `POST /api/movies` - Crear nueva película
- `PUT /api/movies/{id}` - Actualizar película
- `DELETE /api/movies/{id}` - Eliminar película

### Booking Service
- `GET /api/bookings` - Obtener todas las reservas
- `GET /api/bookings/{id}` - Obtener reserva por ID
- `GET /api/bookings/user/{userId}` - Obtener reservas por usuario
- `GET /api/bookings/movie/{movieId}` - Obtener reservas por película
- `GET /api/bookings/status/{status}` - Obtener reservas por estado
- `POST /api/bookings` - Crear nueva reserva
- `PUT /api/bookings/{id}` - Actualizar reserva
- `PUT /api/bookings/{id}/cancel` - Cancelar reserva
- `DELETE /api/bookings/{id}` - Eliminar reserva

### User Service
- `GET /api/users` - Obtener todos los usuarios
- `GET /api/users/{id}` - Obtener usuario por ID
- `GET /api/users/email/{email}` - Obtener usuario por email
- `POST /api/users` - Crear nuevo usuario
- `PUT /api/users/{id}` - Actualizar usuario
- `DELETE /api/users/{id}` - Eliminar usuario

## 📝 Ejemplos de Uso

### Crear una película
```bash
curl -X POST http://localhost:8080/api/movies \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Inception",
    "genre": "Sci-Fi",
    "director": "Christopher Nolan",
    "duration": 148,
    "description": "A thief who steals corporate secrets",
    "rating": 8.8
  }'
```

### Crear un usuario
```bash
curl -X POST http://localhost:8080/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Juan Pérez",
    "email": "juan@example.com",
    "phone": "+123456789",
    "address": "Calle Principal 123"
  }'
```

### Crear una reserva
```bash
curl -X POST http://localhost:8080/api/bookings \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "movieId": 1,
    "movieTitle": "Inception",
    "numberOfSeats": 2,
    "totalPrice": 20.00,
    "showTime": "2025-10-20T19:00:00"
  }'
```

## 🗄️ Base de Datos

Cada microservicio utiliza una base de datos H2 en memoria independiente. Las consolas H2 están habilitadas:

- Movie Service: http://localhost:8081/h2-console
- Booking Service: http://localhost:8082/h2-console
- User Service: http://localhost:8083/h2-console

Credenciales por defecto:
- JDBC URL: Según configuración de cada servicio
- Username: sa
- Password: (vacío)

## 🏛️ Estructura del Proyecto

```
Microservicios-Cine/
├── eureka-server/          # Servidor de descubrimiento
├── api-gateway/            # Gateway API
├── movie-service/          # Servicio de películas
├── booking-service/        # Servicio de reservas
├── user-service/           # Servicio de usuarios
├── docker-compose.yml      # Configuración Docker Compose
├── pom.xml                # POM padre
└── README.md              # Este archivo
```

## 👥 Autor

- RengiCodeMaster

## 📄 Licencia

Este proyecto es de código abierto y está disponible bajo la Licencia MIT.