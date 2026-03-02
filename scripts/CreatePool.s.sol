 //SPDX-License-Identifier: MIT
 pragma solidity ^0.8.0;
 import {Script} from "forge-std/Script.sol";
 import {PoolKey} from "../lib/v4-core/src/types/PoolKey.sol";
 import {CurrencyLibrary} from "../lib/v4-core/src/types/Currency.sol";
 contract CreatePool is Script {
    //For native token pairs (Ether), use CurrencyLibrary.ADDRESS_ZERO as currency0
    address public currency0 = CurrencyLibrary.ADDRESS_ZERO; // Ether
    function run() public {
   PoolKey memory pool = PoolKey({
    currency0: currency0,
    currency1: currency1,
    fee: lpFee,
    tickSpacing: tickSpacing,
    hooks: hookContract
});
    }
}