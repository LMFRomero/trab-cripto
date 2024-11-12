async function main() {
    const CrypTwitter = await ethers.deployContract("CrypTwitter");
    await CrypTwitter.waitForDeployment();
    console.log("Contrato implantado em: ", CrypTwitter.target);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });