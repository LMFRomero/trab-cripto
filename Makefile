compile:
	cd hardhat && npx hardhat compile

deploy:
	cd hardhat && npx hardhat run scripts/deploy.js --network sepolia

start-front:
	cd frontend && python3 -m http.server

create-post:
	cd hardhat && npx hardhat run scripts/interact-create-post.js --network sepolia

get-posts:
	cd hardhat && npx hardhat run scripts/interact-get-posts.js --network sepolia

like-post:
	cd hardhat && npx hardhat run scripts/interact-like.js --network sepolia
