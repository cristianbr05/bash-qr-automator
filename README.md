# 📜 Generador Masivo de Códigos QR (Bash)

![Bash](https://img.shields.io/badge/Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)
![Linux](https://img.shields.io/badge/Linux-FCC624?style=flat-square&logo=linux&logoColor=black)
![Status](https://img.shields.io/badge/Status-Complete-green?style=flat-square)

> **Script de terminal (Bash) para la creación automatizada y por lotes de códigos QR en formato vectorial (`.svg`).**
> Procesa archivos de texto plano validando la integridad de los datos y gestionando la creación de directorios y archivos mediante la herramienta `qrencode`.

| ⚙️ Lenguaje | 📦 Dependencia | 📄 Entrada | 🖨️ Salida |
| :--- | :--- | :--- | :--- |
| Bash Script | `qrencode` | Archivo `.txt` | Múltiples `.svg` |

---

## 🛠️ Funcionalidades principales

* **Procesamiento por lotes:** Lectura secuencial de un archivo `lista.txt` estructurado en pares de líneas (Nombre de archivo y URL de destino).
* **Saneamiento de datos:** Eliminación automática de los retornos de carro de Windows (`\r`) y líneas vacías mediante `sed` y `awk` antes del procesamiento para evitar fallos de formato.
* **Optimización de ejecución:** Comprobación de archivos preexistentes en el directorio de destino para omitir la sobrescritura y ahorrar tiempo de procesamiento.
* **Gestión de errores:** Validación de dependencias instaladas, comprobación de la existencia del archivo de origen y validación de permisos de escritura para la creación del directorio de salida.
* **Auditoría visual:** Interfaz de consola con código de colores ANSI que muestra el estado en tiempo real de cada archivo procesado y genera un panel de resumen estadístico final (creados, omitidos, errores).

---

## 🚀 Instrucciones de uso

1. Instalar la dependencia necesaria en el sistema operativo:
   ```bash
   sudo apt install qrencode