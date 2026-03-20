//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {PoolKey} from "../lib/v4-core/src/types/PoolKey.sol";
import {Currency, CurrencyLibrary} from "../lib/v4-core/src/types/Currency.sol";
import {IHooks} from "../lib/v4-core/src/interfaces/IHooks.sol";
import {IPoolManager} from "../lib/v4-core/src/interfaces/IPoolManager.sol";

contract CreatePool is Script {
    Currency public currency0 = CurrencyLibrary.ADDRESS_ZERO; // Ether
    // ¡REVISA ESTA DIRECCIÓN! No puede ser la misma que el PoolManager
    Currency public currency1 = Currency.wrap(0x5FbDB2315678afecb367f032d93F642f64180aa3); 
    
    uint24 public lpFee = 3000; 
    int24 public tickSpacing = 60;
    IHooks public hookContract = IHooks(address(0));
    
    // Dirección del PoolManager que desplegamos antes
    IPoolManager public poolManager = IPoolManager(0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512);

    function run() public {
        uint160 startingPrice = 79228162514264337593543950336; 

        vm.startBroadcast(); 

        // Definimos el struct correctamente
        PoolKey memory pool = PoolKey({
            currency0: currency0,
            currency1: currency1,
            fee: lpFee,
            tickSpacing: tickSpacing,
            hooks: hookContract
        }); // <-- La llave se cierra AQUÍ

        // Llamamos a la función del manager
        poolManager.initialize(pool, startingPrice);

        vm.stopBroadcast();
    }
}
