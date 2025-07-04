
# Etapa 1: Usar uma imagem base oficial do Python.
# A versão slim é menor e contém apenas o mínimo necessário para rodar Python.
# O readme menciona Python 3.10+, então usaremos 3.11 que é uma versão estável e recomendada.
FROM python:3.11-slim-bullseye

# Etapa 2: Definir o diretório de trabalho dentro do contêiner.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências primeiro.
# Isso aproveita o cache de camadas do Docker. Se o requirements.txt não mudar,
# o Docker não reinstalará as dependências em builds futuros.
COPY requirements.txt .

# Etapa 4: Instalar as dependências.
# --no-cache-dir reduz o tamanho da imagem.
RUN pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o restante do código da aplicação para o diretório de trabalho.
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada.
# O Uvicorn, por padrão, roda na porta 8000.
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação quando o contêiner for executado.
# Usamos --host 0.0.0.0 para tornar a aplicação acessível de fora do contêiner.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
