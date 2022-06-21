import * as dotenv from "dotenv";
import { HardhatUserConfig} from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";

dotenv.config();

const config: HardhatUserConfig = {
    solidity: {
        version: "0.8.15"
    },
    networks: {
        goerli: {
            url: `https://goerli.infura.io/v3/${process.env.INFURAPROJECTID}`,
            accounts: [process.env.PRIVATEKEY!],
        }
    },
    etherscan: {
        apiKey: process.env.ETHERSCAN,
    },
};

export default config;