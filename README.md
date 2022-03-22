# Starter-NFT-Contract

This project is build using [ERC721URIStorage extension](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/extensions/ERC721URIStorage.sol) from [@openzeppelin contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
This project demonstrates an advanced Hardhat use case, integrating other tools commonly used alongside Hardhat in the ecosystem.

See a deployed instance of this project on rinkeby:
> https://rinkeby.etherscan.io/address/0xd8A07E7608E805f7A395B8bb9f4c6E2D5AA53c9D

A react UI to interact with deployed contract:
> https://nft-starter-project.mjtbkh.repl.co/


```shell
npx hardhat compile   # compile contract and generate ABI
npx hardhat run scripts/deploy.ts   # deploy contracts on mainnet
npx hardhat run scripts/deploy.ts --network rinkeby   # deploy contracts on rinkeby testnet
```
