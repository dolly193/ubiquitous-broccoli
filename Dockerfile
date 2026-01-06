# Usa uma imagem base oficial do Python
FROM python:3.9-slim

# Instala dependências do sistema necessárias para o libtorrent e compilação
RUN apt-get update && apt-get install -y \
    gcc \
    g++ \
    libboost-all-dev \
    libtorrent-rasterbar-dev \
    && rm -rf /var/lib/apt/lists/*

# Define o diretório de trabalho
WORKDIR /app

# Instala as dependências Python
# Usamos lbry-libtorrent que é mais compatível com Linux/Docker que o pacote padrão
RUN pip install --no-cache-dir lbry-libtorrent flask mysql-connector-python cryptography werkzeug gunicorn

# Copia o código da aplicação
COPY . .

# Comando para iniciar o servidor
CMD ["gunicorn", "-w", "4", "-b", "0.0.0.0:5000", "app:app"]