import {expect} from "chai";
import { ethers } from "hardhat";
import { basicSetup, deploy } from "./helpers";

describe("SimpleEscrowFactory", function() {

    it("Can deploy contract", async function () {
        const {payer, payee, llama, token, factory} = await basicSetup();
        token.approve(factory.address, "10000");
        await factory.connect(payer).createEscrow(payee.address, token.address, "10000");
    })

    it("Contract created is correct", async function () {
        const {payer, payee, llama, token, factory} = await basicSetup();
        const contract = await deploy("SimpleEscrowContract", [payer.address, payee.address, llama.address, token.address]);
        
    })
   
})