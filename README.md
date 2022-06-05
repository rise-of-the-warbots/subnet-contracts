# Subnet contracts
<img src="imgs/icon_nmac.png" width="100">

This repository contains a collection of contracts, which are the core ecosystem of the NMAC EVM Subnet

## WNMAC

WNMAC or Wrapped NMAC is an [ERC-20](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md) compatible wrapper contract around the NMAC token.

On the Rise of the Warbots subnet, NMAC is treated just like standard ETH is on Ethereum. This means that NMAC lacks the standardized interfaces that make ERC-20 tokens so interchangeable. WNMAC corrects this by issuing one ERC-20 WNMAC token for each NMAC deposited. Each WNMAC is then redeemable for an equal amount of NMAC.

### Implementation
WNMAC is based on the implementation of Canonical WETH developed by the Ethereum community. Details are available [here](https://blog.0xproject.com/canonical-weth-a9aa7d0279dd) and original source code is available here: https://github.com/gnosis/canonical-weth.

The WNMAC implementation only changes the underlying contract to reflect the new token name of "Wrapped NMAC" and the new symbol "WNMAC".

### Security
Because this contract is a fork of canonical WETH, it has the same security characteristics of the Gnosis WETH implementation. That contract has been in circulation for several years and has been thoroughly audited.

### Deployment
- Testnet: 0xCc71F1e515Ebd0e9810A7C1762C2e716D26E9Fbb

## NMACFaucet

This is a simple (and therefore sufficiently secure) faucet for the testnet of the NMAC EVM Subnet. The owner can control the amount which can be requested and users can withdraw that amount once every day. Users may also donate to the faucet.

There is an onwer-privileged withdraw function, which allows the owner to withdraw an arbitrary amount from the faucet for emergencies or in migration scenarios.

### Deployment
- Testnet: 0x5E4edA21d9848CF5fc9242c7eE4956202544941e
