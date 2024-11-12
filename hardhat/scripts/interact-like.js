async function main() {
    const { CONTRACT_ADDR } = process.env;
    const CrypTwitter = await ethers.getContractFactory("CrypTwitter")
    const contract = CrypTwitter.attach(CONTRACT_ADDR)

    const id = "0"

    const tx = await contract.likePost(id)
    await tx.wait()

    console.log(`Post curtido`)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    });