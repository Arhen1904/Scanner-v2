FROM python:3.10-slim

# Instalar dependencias del sistema necesarias para OpenCV
RUN apt-get update && apt-get install -y libgl1-mesa-glx libc6 libglib2.0-0 && rm -rf /var/lib/apt/lists/*

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos del proyecto
COPY . .

# Instalar dependencias de Python
RUN pip install --no-cache-dir -r requirements.txt

# Exponer el puerto
EXPOSE 5000

# Comando para iniciar tu app
CMD ["python", "server.py"]
