# ========================================
# DOCKERFILE PARA BACKEND NODE.JS
# ========================================
# Este arquivo define como construir a imagem Docker da aplicação backend

# Imagem base: Node.js versão 18 com Alpine Linux (imagem leve)
FROM node:18-alpine

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de dependências primeiro (para cache otimizado)
# Isso permite que o Docker reutilize esta camada se as dependências não mudaram
COPY package*.json ./

# Instala as dependências da aplicação
# Executa apenas se package.json ou package-lock.json mudaram
RUN npm install

# Copia todo o código fonte da aplicação para o container
# Isso é feito após instalar dependências para otimizar o cache do Docker
COPY . .

# Informa qual porta a aplicação irá usar
# Essa porta deve corresponder à porta configurada no código da aplicação
EXPOSE 5000

# Comando que será executado quando o container iniciar
# Executa o script "start" definido no package.json
CMD ["npm", "start"]

# ========================================
# PROCESSO DE BUILD:
# ========================================
# 1. Usa Node.js 18 Alpine como base (imagem pequena e segura)
# 2. Define /app como diretório de trabalho
# 3. Copia package*.json para instalar dependências
# 4. Executa npm install para baixar e instalar pacotes
# 5. Copia todo o código fonte da aplicação
# 6. Expõe a porta 5000 para comunicação
# 7. Define o comando de inicialização (npm start)
#
# Otimizações:
# - Ordem das camadas otimizada para cache (dependências antes do código)
# - Imagem Alpine reduz tamanho final
# - EXPOSE documenta a porta usada pela aplicação