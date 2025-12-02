# ============================
# 1. Construir la aplicación
# ============================
FROM maven:3.9.6-amazoncorretto-21 AS build
WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn -q -e -DskipTests package

# ============================
# 2. Crear imagen final ligera
# ============================
FROM amazoncorretto:21

WORKDIR /app

# Copiar el .jar generado
COPY --from=build /app/target/*.jar app.jar

# Exponer el puerto
EXPOSE 8080

# Comando de inicio
ENTRYPOINT ["java", "-jar", "app.jar"]
