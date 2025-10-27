# Sistema de Microservicios para Cine - Documentación Técnica

## Resumen Ejecutivo

Se ha implementado un sistema completo de gestión de cine basado en arquitectura de microservicios utilizando Spring Boot y Spring Cloud. El sistema permite la gestión de películas, reservas de boletos y usuarios de manera distribuida y escalable.

## Arquitectura del Sistema

### Componentes Principales

1. **Eureka Server** (Puerto 8761)
   - Servidor de descubrimiento de servicios
   - Permite el registro y descubrimiento automático de microservicios
   - Proporciona alta disponibilidad y balanceo de carga

2. **API Gateway** (Puerto 8080)
   - Punto de entrada único para todas las peticiones
   - Enrutamiento inteligente a los microservicios
   - Integración con Eureka para descubrimiento de servicios

3. **Movie Service** (Puerto 8081)
   - Gestión completa de películas (CRUD)
   - Búsqueda por título y filtrado por género
   - Base de datos H2 independiente

4. **Booking Service** (Puerto 8082)
   - Gestión de reservas de boletos
   - Seguimiento del estado de reservas
   - Consultas por usuario, película y estado
   - Base de datos H2 independiente

5. **User Service** (Puerto 8083)
   - Gestión de usuarios/clientes
   - Operaciones CRUD completas
   - Búsqueda por email
   - Base de datos H2 independiente

## Tecnologías Utilizadas

- **Java 17**: Lenguaje de programación
- **Spring Boot 3.1.5**: Framework de aplicación
- **Spring Cloud 2022.0.4**: Herramientas para microservicios
- **Spring Cloud Netflix Eureka**: Descubrimiento de servicios
- **Spring Cloud Gateway**: API Gateway
- **Spring Data JPA**: Persistencia de datos
- **H2 Database**: Base de datos en memoria
- **Lombok**: Reducción de código boilerplate
- **Maven**: Gestión de dependencias y construcción
- **Docker**: Contenedorización
- **Docker Compose**: Orquestación de contenedores

## Endpoints de la API

### Servicio de Películas

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | /api/movies | Obtener todas las películas |
| GET | /api/movies/{id} | Obtener película por ID |
| GET | /api/movies/genre/{genre} | Filtrar por género |
| GET | /api/movies/search?title={title} | Buscar por título |
| POST | /api/movies | Crear nueva película |
| PUT | /api/movies/{id} | Actualizar película |
| DELETE | /api/movies/{id} | Eliminar película |

### Servicio de Usuarios

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | /api/users | Obtener todos los usuarios |
| GET | /api/users/{id} | Obtener usuario por ID |
| GET | /api/users/email/{email} | Obtener usuario por email |
| POST | /api/users | Crear nuevo usuario |
| PUT | /api/users/{id} | Actualizar usuario |
| DELETE | /api/users/{id} | Eliminar usuario |

### Servicio de Reservas

| Método | Endpoint | Descripción |
|--------|----------|-------------|
| GET | /api/bookings | Obtener todas las reservas |
| GET | /api/bookings/{id} | Obtener reserva por ID |
| GET | /api/bookings/user/{userId} | Obtener reservas por usuario |
| GET | /api/bookings/movie/{movieId} | Obtener reservas por película |
| GET | /api/bookings/status/{status} | Filtrar por estado |
| POST | /api/bookings | Crear nueva reserva |
| PUT | /api/bookings/{id} | Actualizar reserva |
| PUT | /api/bookings/{id}/cancel | Cancelar reserva |
| DELETE | /api/bookings/{id} | Eliminar reserva |

## Modelos de Datos

### Movie (Película)
```json
{
  "id": "Long",
  "title": "String",
  "genre": "String",
  "director": "String",
  "duration": "Integer",
  "description": "String",
  "rating": "Double"
}
```

### User (Usuario)
```json
{
  "id": "Long",
  "name": "String",
  "email": "String",
  "phone": "String",
  "address": "String"
}
```

### Booking (Reserva)
```json
{
  "id": "Long",
  "userId": "Long",
  "movieId": "Long",
  "movieTitle": "String",
  "numberOfSeats": "Integer",
  "totalPrice": "Double",
  "showTime": "LocalDateTime",
  "status": "String",
  "bookingDate": "LocalDateTime"
}
```

## Características Implementadas

### Funcionalidades Principales
- ✅ CRUD completo para películas, usuarios y reservas
- ✅ Búsqueda y filtrado de películas
- ✅ Gestión de estados de reservas (CONFIRMED, CANCELLED)
- ✅ Validación automática de fechas de reserva
- ✅ Integración entre servicios

### Características de Microservicios
- ✅ Descubrimiento de servicios con Eureka
- ✅ API Gateway para enrutamiento
- ✅ Bases de datos independientes por servicio
- ✅ Escalabilidad horizontal
- ✅ Desacoplamiento de servicios

### DevOps
- ✅ Dockerización de todos los servicios
- ✅ Docker Compose para despliegue local
- ✅ Scripts de construcción automatizada
- ✅ Scripts de prueba automatizados
- ✅ Consolas H2 para inspección de datos

## Instrucciones de Despliegue

### Opción 1: Ejecución Manual

1. Compilar el proyecto:
```bash
./build.sh
# o manualmente:
mvn clean package -DskipTests
```

2. Iniciar servicios en orden:
```bash
# Terminal 1: Eureka Server
cd eureka-server && java -jar target/eureka-server-1.0.0.jar

# Terminal 2: API Gateway
cd api-gateway && java -jar target/api-gateway-1.0.0.jar

# Terminal 3: Movie Service
cd movie-service && java -jar target/movie-service-1.0.0.jar

# Terminal 4: Booking Service
cd booking-service && java -jar target/booking-service-1.0.0.jar

# Terminal 5: User Service
cd user-service && java -jar target/user-service-1.0.0.jar
```

### Opción 2: Docker Compose

```bash
# Compilar
mvn clean package -DskipTests

# Iniciar todos los servicios
docker-compose up -d

# Detener servicios
docker-compose down
```

## Pruebas

### Ejecución de Pruebas Automatizadas

```bash
./test-api.sh
```

Este script verifica:
- Estado de Eureka Server
- Registro de servicios
- Creación de películas
- Creación de usuarios
- Creación de reservas
- Funcionalidad de búsqueda

### Verificación Manual

1. **Eureka Dashboard**: http://localhost:8761
2. **Crear una película**:
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

3. **Crear un usuario**:
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

4. **Crear una reserva**:
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

## Seguridad

- ✅ Análisis de seguridad CodeQL completado - 0 vulnerabilidades encontradas
- ✅ Validación de dependencias realizada
- ℹ️ Sistema diseñado para desarrollo/demostración
- ℹ️ Para producción se recomienda agregar:
  - Autenticación y autorización (Spring Security + JWT)
  - HTTPS/TLS
  - Rate limiting
  - Monitoreo y logging centralizado

## Mejoras Futuras Recomendadas

1. **Seguridad**
   - Implementar Spring Security
   - Agregar autenticación JWT
   - Configurar CORS adecuadamente

2. **Persistencia**
   - Migrar a bases de datos relacionales (PostgreSQL, MySQL)
   - Implementar migraciones con Flyway/Liquibase

3. **Observabilidad**
   - Agregar Spring Cloud Sleuth para trazabilidad
   - Implementar Zipkin para rastreo distribuido
   - Configurar ELK Stack para logs

4. **Resiliencia**
   - Implementar Circuit Breaker con Resilience4j
   - Agregar retry y timeout policies
   - Implementar health checks avanzados

5. **Funcionalidades**
   - Servicio de notificaciones (email/SMS)
   - Integración de pagos
   - Sistema de reseñas y calificaciones
   - Gestión de salas y horarios

## Conclusión

El sistema implementado proporciona una base sólida para un sistema de gestión de cine utilizando arquitectura de microservicios. Todos los componentes están funcionando correctamente, probados y documentados. El sistema es escalable, mantenible y sigue las mejores prácticas de desarrollo de microservicios con Spring Boot.
