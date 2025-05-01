FROM python:3.10-slim

# Instalar dependencias del sistema necesarias
RUN apt-get update && apt-get install -y \
    libgomp1 \
    libgl1-mesa-glx \
    libglib2.0-0 \
    libsm6 \
    libxrender1 \
    libxext6 \
    libzbar0 \
    && rm -rf /var/lib/apt/lists/*

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar los archivos del proyecto
COPY . .

# Instalar las dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto (ajusta según tu aplicación)
EXPOSE 5000

# Comando para iniciar tu aplicación
CMD ["python", "server.py"]
