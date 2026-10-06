#!/bin/bash

# Directorio local 'codigo_qr' en la ruta de ejecución del script
DEST_DIR="$(pwd)/codigo_qr"
LISTA="lista.txt"

# Definición de colores ANSI
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # Sin color

echo -e "${CYAN}=================================================${NC}"
echo -e "${CYAN}         Generador Masivo de Códigos QR          ${NC}"
echo -e "${CYAN}=================================================${NC}"

# Comprobar si qrencode está instalado
if ! command -v qrencode &> /dev/null; then
    echo -e "${RED}❌ Error: 'qrencode' no está instalado.${NC}"
    echo -e "Ejecuta: sudo apt install qrencode"
    exit 1
fi

# Comprobar si el archivo existe y no está vacío (-s)
if [ ! -s "$LISTA" ]; then
    echo -e "${RED}❌ Error: El archivo '$LISTA' no existe o está vacío.${NC}"
    exit 1
fi

# Crear la carpeta 'codigo_qr' si no existe y validar errores de creación
if [ ! -d "$DEST_DIR" ]; then
    mkdir -p "$DEST_DIR" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ Error: No se pudo crear el directorio '$DEST_DIR'.${NC}"
        exit 1
    fi
fi

# Inicializar contadores
creados=0
omitidos=0
errores=0

echo -e "Iniciando procesamiento...\n"

# Bucle mejorado con < <() para evitar subshells y no perder los contadores
# Se limpia el retorno de carro (\r) automáticamente para evitar fallos de Windows
while read -r nombre; do
    read -r url
    
    if [ -z "$url" ] || [ -z "$nombre" ]; then
        echo -e "${RED}❌ Formato inválido -> Nombre o URL faltante cerca de: $nombre${NC}"
        ((errores++))
        continue
    fi

    if [ -f "${DEST_DIR}/${nombre}.svg" ]; then 
        echo -e "${YELLOW}⚠️  Omitido (Ya existe) -> ${nombre}.svg${NC}"
        ((omitidos++))
        continue
    fi

    # Generar QR
    qrencode -s 10 -l L -t SVG -o "${DEST_DIR}/${nombre}.svg" "$url"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Creado -> ${nombre}.svg${NC}"
        ((creados++))
    else
        echo -e "${RED}❌ Error al generar -> ${nombre}.svg${NC}"
        ((errores++))
    fi
done < <(sed -e 's/\r//g' "$LISTA" | awk 'NF')

# Panel resumen
echo -e "\n${CYAN}=================================================${NC}"
echo -e "📊 ${CYAN}RESUMEN DE EJECUCIÓN${NC}"
echo -e "${CYAN}=================================================${NC}"
echo -e "${GREEN}✅ Generados con éxito: $creados${NC}"
echo -e "${YELLOW}⚠️  Omitidos (Existentes): $omitidos${NC}"
echo -e "${RED}❌ Errores: $errores${NC}"
echo -e "${CYAN}📂 Ruta de guardado: ${NC}$DEST_DIR"
echo -e "${CYAN}=================================================${NC}\n"