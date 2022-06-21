import {ethers} from "hardhat";

export async function deploy(name: string, args: string[] = []) {
    const Contract = await ethers.getContractFactory(name);
    const contract = await Contract.deploy(...args);
    await contract.deployed();
    return contract
}

export async function basicSetup() {
    const token = await deploy("MockToken");
    const [payer, payee, llama] = await ethers.getSigners();
    await token.connect(payer).mint();
    const factory = await deploy("SimpleEscrowFactory",[ llama.address]);
    return {payer, payee, llama, token, factory};
}