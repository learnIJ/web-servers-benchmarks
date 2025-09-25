# Contexto

Se han levantado dos servidores, uno con la librería fiber y otro con
la librería gin. Ambas librerías del lenguaje de programación Go.

# Casos de prueba

1º Peticiones desde dos hosts distintos a un mismo servidor
2º Peticiones desde un host al servidor mediante localhost
3º Peticiones desde un host al servidor mediante red directa (sin intervenci
ón del router)

Todas las pruebas se han realizado con dos scripts de bash, 
ambos en la carpeta `scripts`:
- requests.sh (XARGS)
- parallel-requests.sh (Parallels)

Se ha probado enviando 10000 peticiones en el menor tiempo posible al servidor.

# Resultados obtenidos

El módulo de parallels que estábamos utilizando no aprovechaba bien todos
los núcleos del ordenador para el envío de peticiones. Por tanto, hemos optado
por fiarnos solo del que utiliza XARGS.

En todas las pruebas se ha determinado que los hosts no eran capaces de saturar
los servidores con peticiones, creemos que por culpa de los núcleos del procesador.

GoFiber --> 100000 req - 76.37 segundos

### Python - FastAPI
Launching 100000 requests with 12 parallel processes...
--------------------------------------------------------
Requests attempted: 100000
Successful (HTTP 200): 50438
Failed (non-200 or error): 49562
Total Time: 96.269973000 seconds
Throughput (approx): 523.92 req/sec
