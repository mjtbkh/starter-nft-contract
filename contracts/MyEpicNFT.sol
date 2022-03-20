// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";
import { Base64 } from "./libraries/Base64.sol";

contract MyEpicNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    event NewEpicNFTMinted(address sender, uint256 tokenId);
    uint8 constant private MAX_TOTAL_MINTS = 50;
    uint8 private TOTAL_MINTS = 0;

    string private baseSvg1 = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='";
    string private baseSvg2 = "' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";


    string[] firstWords = ["Fantastic", "Epic", "Terrible", "Mad", "Crazy", "Spooky", "Wild", "Roaring", "Colorful"];
    string[] secondWords = ["Cupcake", "Pizza", "Hamburger", "Tacco", "Curry", "Spaghetti", "Soup", "Chicken"];
    string[] thirdWords = ["Minato", "Gaara", "Goku", "Naruto", "Sasuke", "Sakura", "Kakashi", "Madara"];
    string[] colors = ["red", "orange", "yello", "blue", "black", "purple"];

    constructor() ERC721("SquareNFT", "SQUARE") {
        console.log("This is my NFT contract. Whoa!");
    }

    function getTotalMints() public view returns (uint8) {
        return TOTAL_MINTS;
    }

    function pickRandFirstWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandSecondWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandThirdWord(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    function pickRandColor(uint256 tokenId) public view returns (string memory) {
        uint256 rand = random(string(abi.encodePacked("COLOR", Strings.toString(tokenId))));
        rand = rand % colors.length;
        return colors[rand];
    }

    function random(string memory input) internal pure returns (uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function makeAnEpicNFT() public {
        require(TOTAL_MINTS < MAX_TOTAL_MINTS, "All NFTs are minted!");
        TOTAL_MINTS += 1;
        uint newItemId = _tokenIds.current();

        string memory first = pickRandFirstWord(newItemId);
        string memory second = pickRandSecondWord(newItemId);
        string memory third = pickRandThirdWord(newItemId);
        string memory color = pickRandColor(newItemId);
        string memory combinedWord = string(abi.encodePacked(first, second, third));

        string memory finalSvg = string(abi.encodePacked(baseSvg1, color, baseSvg2, first, second, third, "</text></svg>"));
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "',
                        combinedWord,
                        '", "description": "A highly acclaimed collection of squares.", "image": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(finalSvg)),
                        '"}'
                    )
                )
            )
        );

        string memory finalTokenUri = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        console.log("\n--------------------");
        console.log(
            string(
                abi.encodePacked(
                    "https://nftpreview.0xdev.codes/?code=",
                    finalTokenUri
                )
            )
        );
        console.log("--------------------\n");

        _safeMint(msg.sender, newItemId);
        _setTokenURI(newItemId, finalTokenUri);
        _tokenIds.increment();
        console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
        emit NewEpicNFTMinted(msg.sender, newItemId);
    }
}
