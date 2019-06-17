pragma solidity ^0.5.6;

import "ds-proxy/proxy.sol";


contract ERC20Interface {
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
}

contract CdcExchangeInterface {
    function buyTokensWithFee() public payable returns (uint tokens);
}

contract CdcProxy {
    DSProxyFactory public factory;

    constructor(DSProxyFactory factory_) public {
        factory = factory_;
    }

    function buy(
        ERC20Interface cdc,
        CdcExchangeInterface cdcex
    )
        public payable returns (uint tokens)
    {
        tokens = cdcex.buyTokensWithFee.value(msg.value)();
        cdc.transferFrom(address(this), msg.sender, tokens);
        return tokens;
    }

    function createProxyAndBuy(
        ERC20Interface cdc,
        CdcExchangeInterface cdcex
    )
        public payable returns (uint tokens)
    {
        factory.build(msg.sender);
        tokens = buy(cdc, cdcex);
        return tokens;
    }
}
