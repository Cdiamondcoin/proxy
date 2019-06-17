pragma solidity ^0.5.6;

import "ds-test/test.sol";
import "ds-proxy/proxy.sol";
import "./CdcProxy.sol";


contract CdcProxyTest is DSTest {
    DSProxyFactory factory;
    CdcProxy proxy;

    function setUp() public {
        factory = new DSProxyFactory();
        proxy = new CdcProxy(factory);
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}