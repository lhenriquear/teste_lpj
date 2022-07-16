# Teste Desenvolvedor Python LPJ

Repositório com os arquivos e códigos solicitados no teste.


# SQL

As consultas SQL estão contidas no arquivo *"consultas.sql*"



# Python

O arquivo com o código python está no arquivo *"teste.ipynb*

Os arquivos gerados pelo código python seguem a estrutura *df_"terminacao".parquet.gzip*




## Diagrama

```mermaid
graph LR
A[Carregara sobre regras }
D --> E((Divide dados dos arquivos))
E --> F((Salva em parquet))Regras]  --> B((Carregar arquivos))
B --> D{Itera sobre regras }
D --> E((Divide dados dos arquivos))
E --> F((Salva em parquet))
```
