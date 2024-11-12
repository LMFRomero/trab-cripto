require('dotenv')

function postFromSlice(array) {
    if (array.length != 5) throw new Error("invalid length to create post")

    const obj = {
        id: array[0],
        user: array[1],
        timestamp: array[2],
        content: array[3],
        likes: array[4]
    }

    return obj
}

async function main() {
    const { CONTRACT_ADDR } = process.env;
    const CrypTwitter = await ethers.getContractFactory("CrypTwitter")
    const contract = CrypTwitter.attach(CONTRACT_ADDR)

    const posts = String(await contract.getFeed(0, 2)).split(",")

    var postsObj = []

    if (posts.length == 1) {
        console.log("No posts");
        return;
    }

    for (var i = 0; i < posts.length; i += 5) {
        postsObj.push(postFromSlice(posts.slice(i, i+5)))
    }

    for (const obj of postsObj)
        console.log(`Posts: ${JSON.stringify(obj)}`);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });