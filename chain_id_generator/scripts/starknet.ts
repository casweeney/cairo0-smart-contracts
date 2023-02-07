import { constants } from "starknet";

async function main() {
    const alphaGoerliChainId = constants.StarknetChainId.TESTNET;
    const alphaGoerli2ChainId = constants.StarknetChainId.TESTNET2;
    const mainnetChainD = constants.StarknetChainId.MAINNET;

    // const hexToString = parseInt(alphaGoerli2ChainId, 16);

    console.log("Chain ID: ", alphaGoerli2ChainId);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
});