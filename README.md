# DefiLab - Laboratorio de Finanzas Descentralizadas

**DefiLab** es un entorno experimental diseñado para el desarrollo, prueba y despliegue de soluciones financieras descentralizadas (DeFi). El proyecto se centra principalmente en la arquitectura de **Uniswap v4**, proporcionando una base sólida para explorar contratos inteligentes de vanguardia, automatización mediante agentes de IA y dashboards informativos.

## 🚀 Tecnologías Principales

- **[Solidity](https://soliditylang.org/):** Lenguaje de programación para los contratos inteligentes.
- **[Foundry](https://book.getfoundry.sh/):** Marco de desarrollo de Ethereum ultrarrápido (forge, cast, anvil).
- **[Uniswap v4](https://github.com/Uniswap/v4-core):** Protocolo AMM de próxima generación con arquitectura Singleton y Hooks.
- **[OpenZeppelin](https://openzeppelin.com/contracts/):** Biblioteca estándar para la implementación segura de tokens ERC20.
- **Bootstrap/HTML5:** Interfaz de usuario y documentación visual ubicada en la carpeta `docs/`.

## 📁 Estructura del Proyecto

- `contracts/`: Contiene contratos inteligentes personalizados, como tokens ERC20 para pruebas.
- `scripts/`: Scripts de Foundry para automatizar el despliegue del `PoolManager` y la creación de pools.
- `lib/`: Dependencias externas (Uniswap v4 Core y Periphery, OpenZeppelin).

- `.agents/`: Habilidades especializadas para interactuar con el laboratorio a través de inteligencia artificial.

## 🛠 Configuración Inicial

Para comenzar a trabajar en el laboratorio, asegúrate de tener instalado [Foundry](https://book.getfoundry.sh/getting-started/installation).

1. **Instalar dependencias:**
   ```bash
   forge install
   ```

2. **Ejecutar un nodo local (Anvil):**
   Debido al tamaño de los contratos de Uniswap v4, se recomienda aumentar el límite de tamaño del código:
   ```bash
   anvil --code-size-limit 100000
   ```

## 📜 Guía de Despliegue

### 1. Desplegar Token ERC20 de Prueba
Utiliza la cuenta predeterminada de Anvil para desplegar un token para tus pruebas:
Setea Private Key con export PRIVATE_KEY="Clave de Anvil"
```bash
forge create --rpc-url http://127.0.0.1:8545 \
  --private-key $PRIVATE_KEY \
  contracts/Erc20.sol:Token --broadcast
```
va a salir algo como esto:
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Transaction hash: 0x7522066be4a7dc2e07a39db97996ac3e2dcd44c1a95f10fc6cc9d265c9e10ba7

### 2. Desplegar PoolManager (Uniswap v4)
El `PoolManager` es el contrato central (Singleton) que gestiona todos los pools:
```bash
forge create --broadcast lib/v4-core/src/PoolManager.sol:PoolManager \
  --rpc-url http://127.0.0.1:8545 \
  --private-key $PRIVATE_KEY\
  --constructor-args $CONTRACT_HASH 
```
va a salir algo como esto 
Deployer: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
Deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512
Transaction hash: 0xf8510c87bbf52a354ee3d31089f1d19be3d0dd328f266878f351caa0c0cc69aa

Save the contract hash in this case 

export POOL_MANAGER_HASH=" 0xf8510c87bbf52a354ee3d31089f1d19be3d0dd328f266878f351caa0c0cc69aa"


### 3. Crear un Pool de Liquidez
Puedes usar los scripts predefinidos en la carpeta `scripts/` para inicializar pools con pares de tokens específicos.

 Pasos para crear el Pool:

   1. Asegúrate de tener tu clave privada configurada:
     Si estás usando Anvil localmente, usa la primera clave privada que te da
  el nodo:
   1    export PRIVATE_KEY="tu_clave_privada_de_anvil"

   2. Verifica las direcciones en el script:
     Abre scripts/CreatePool.s.sol y asegúrate de que currency1 y poolManager
  coincidan con las direcciones que obtuviste al desplegar el token y el
  manager en los pasos anteriores.

   3. Ejecuta el script de creación:
     Usa el siguiente comando para ejecutar el script y realizar la transacción
  en tu nodo local:

   1    forge script scripts/CreatePool.s.sol:CreatePool \
   2      --rpc-url http://127.0.0.1:8545 \
   3      --private-key $PRIVATE_KEY \
   4      --broadcast

  ¿Qué hace este script?
   - Define un par de tokens (Ether y tu Token ERC20).
   - Configura una comisión del 0.3% (lpFee = 3000).
   - Establece un precio inicial (en formato Q64.96).
   - Llama a la función initialize del PoolManager para crear formalmente el
     pool en Uniswap v4.

     
## 📊 Dashboard y Visualización
El proyecto incluye una interfaz web interactiva. Para verla, puedes abrir el archivo `docs/defilab.html` en tu navegador. Esta interfaz sirve como un portal para monitorizar el estado del laboratorio y acceder a guías técnicas.

---
*Este proyecto es parte de una iniciativa para democratizar el acceso y la comprensión técnica de los protocolos DeFi modernos.*
