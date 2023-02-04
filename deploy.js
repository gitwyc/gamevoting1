const hre = require("hardhat");

async function main() {

  const GameFactory = await ethers.getContractFactory("GameFactory");

  const gameFactory = await GameFactory.deploy();
  await gameFactory.deployed();

  console.log("GameFactory deployed to:", gameFactory.address);

  const Game = await ethers.getContractFactory("Game");

  const game = await Game.deploy( // with arguments
    "0x326C977E6efc84E512bB9C30f76E30c160eD06FB", // address IERC20 token
    1, // depost
    120, // number of users
    89, // 
  );
  await game.deployed();

  console.log("Game deployed to:", game.address);
}

main() 
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
