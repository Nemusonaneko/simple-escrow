import { deploy } from "../test/helpers";

async function main() {
    const factory = await deploy("SimpleEscrowFactory", ["0xFE5eE99FDbcCFAda674A3b85EF653b3CE4656e13"]);
    console.log("deployed to:", factory.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });