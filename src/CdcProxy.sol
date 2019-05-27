pragma solidity ^0.5.6;

contract ERC20Interface {
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);
}

contract CdcExchangeInterface {
    function buyTokensWithFee() public payable returns (uint tokens);
    function buyTokens() public payable returns (uint tokens);
    function fee() public view returns (uint);

    event LogBuyTokenWithFee(
        address owner,
        address sender,
        uint ethValue,
        uint cdcValue,
        uint rate,
        uint fee
    );
}

// seth calldata "buy(address,address,address,address)" 0xb30041fF94fc8Fc071029F0ABc925A60B5a2059A 0x42aC13dA77bc7204b61C8a44Acba4411Fc34bbbf 0xe4e6e8aa984603e01685369ae9a204a55F17D4Ae 0x17645c5C8f208352B8cb02399Fa6B65630100C0B
contract CdcProxy {
    function buy(ERC20Interface dpt, ERC20Interface cdc, CdcExchangeInterface cdcex, address proxy) public payable {
        uint fee = cdcex.fee();
        dpt.transferFrom(msg.sender, proxy, fee);
        dpt.approve(address(cdcex), fee);
        uint tokens = cdcex.buyTokensWithFee.value(msg.value)();
        cdc.transferFrom(proxy, msg.sender, tokens);
    }
}
