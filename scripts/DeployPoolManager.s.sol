//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import {PoolManager} from "../lib/v4-core/src/PoolManager.sol";

contract DeployPoolManager is Script {
    function run() public {
        vm.startBroadcast();
        new PoolManager(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266); // owner
        vm.stopBroadcast();
    }
}