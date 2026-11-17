# Imagen base oficial de Python liviana
FROM python:3.11-slim

# Evitar generación de archivos .pyc y habilitar salida de logs sin buffer
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Directorio de trabajo donde reside manage.py
WORKDIR /app

# Instalar dependencias del sistema necesarias para compilación de paquetes
RUN apt-get update && apt-get install -y --no-install-recommends gcc && rm -rf /var/lib/apt/lists/*

# Copiar e instalar dependencias de Python aprovechando caché de capas
COPY requirements.txt /app/
RUN pip install --no-cache-dir --upgrade pip && pip install --no-cache-dir -r requirements.txt

# Copiar el código fuente completo del proyecto
COPY . /app/

# Exponer el puerto estándar de ejecución de Django
EXPOSE 8000

# Comando por defecto para iniciar el servidor web
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
