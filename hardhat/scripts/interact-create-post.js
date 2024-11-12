require('dotenv')

async function main() {
    const { CONTRACT_ADDR } = process.env;
    const CrypTwitter = await ethers.getContractFactory("CrypTwitter")
    const contract = CrypTwitter.attach(CONTRACT_ADDR)

    const content = "Trabalho de Smart Contracts!"

    const tx = await contract.createPost(content)
    await tx.wait()

    console.log(`Post criado`)
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error)
        process.exit(1)
    });