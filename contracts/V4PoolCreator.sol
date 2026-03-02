 import {PoolKey} from "/v4-core/src/types/PoolKey.sol";

PoolKey memory pool = PoolKey({
    currency0: currency0,
    currency1: currency1,
    fee: lpFee,
    tickSpacing: tickSpacing,
    hooks: hookContract
});