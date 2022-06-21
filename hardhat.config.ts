import { HardhatUserConfig} from "hardhat/config";
import "@nomiclabs/hardhat-etherscan";
import "@nomiclabs/hardhat-waffle";
import "@typechain/hardhat";
const config: HardhatUserConfig = {
    solidity: {
        version: "0.8.15"
    }
};

export default config;