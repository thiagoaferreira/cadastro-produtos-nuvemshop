#!/bin/bash

# Script de Build e Deploy - Cadastro Produtos Nuvemshop
# Gama Laser

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Nome da imagem
IMAGE_NAME="gamalaser/cadastro-nuvemshop"
TAG="latest"

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   Build - Cadastro Produtos Nuvemshop ${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Verificar se Docker está instalado
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker não está instalado!${NC}"
    exit 1
fi

# Build da imagem
echo -e "${YELLOW}📦 Construindo imagem Docker...${NC}"
docker build -t ${IMAGE_NAME}:${TAG} .

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Imagem construída com sucesso!${NC}"
else
    echo -e "${RED}❌ Erro ao construir imagem!${NC}"
    exit 1
fi

# Perguntar se deseja rodar localmente
echo ""
read -p "Deseja executar o container localmente para teste? (s/n) " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Ss]$ ]]; then
    # Parar container existente se houver
    echo -e "${YELLOW}🛑 Parando container existente...${NC}"
    docker stop cadastro-produtos-nuvemshop 2>/dev/null
    docker rm cadastro-produtos-nuvemshop 2>/dev/null
    
    # Executar novo container
    echo -e "${YELLOW}🚀 Iniciando container...${NC}"
    docker run -d \
        --name cadastro-produtos-nuvemshop \
        -p 8080:80 \
        --restart unless-stopped \
        ${IMAGE_NAME}:${TAG}
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Container rodando!${NC}"
        echo -e "${GREEN}📍 Acesse: http://localhost:8080${NC}"
    else
        echo -e "${RED}❌ Erro ao iniciar container!${NC}"
        exit 1
    fi
fi

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Para fazer deploy no EasyPanel:${NC}"
echo ""
echo "1. Faça commit e push para o GitHub:"
echo "   git add ."
echo "   git commit -m 'Deploy inicial'"
echo "   git push origin main"
echo ""
echo "2. No EasyPanel:"
echo "   - Crie novo App"
echo "   - Escolha 'GitHub'"
echo "   - Selecione o repositório: cadastro-produtos-nuvemshop"
echo "   - Configure a porta: 80"
echo "   - Configure o domínio desejado"
echo "   - Deploy!"
echo ""
echo -e "${GREEN}========================================${NC}"
