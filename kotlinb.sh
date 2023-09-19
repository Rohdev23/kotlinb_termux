#!/data/data/com.termux/files/usr/bin/bash

# Verifica se o número de argumentos é menor que 1
if [ $# -lt 1 ]; then
    echo "Uso: $0 <arquivo.kt>"
    exit 1
fi

# Obtém o nome do arquivo sem a extensão
filename=$(basename -- "$1")
filename="${filename%.*}"

# Compila o código Kotlin
kotlinc $1 -include-runtime -d "$filename.jar"

# Verifica se a compilação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Compilação concluída com sucesso. Arquivo $filename.jar criado."

    # Pergunta ao usuário se deseja executar o arquivo .jar
    read -p "Deseja executar o arquivo $filename.jar? (s/n) " choice
    case "$choice" in 
      s|S ) java -jar "$filename.jar";;
      n|N ) echo "Execução do arquivo $filename.jar cancelada.";;
      * ) echo "Escolha inválida. Saindo.";;
    esac
else
    echo "Erro durante a compilação."
fi
