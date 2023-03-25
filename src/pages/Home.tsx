import { ethers } from "ethers";
import { InjectedConnector } from "wagmi/connectors/injected";
import React, { useEffect, useState } from "react";
import { useAccount, useConnect, useDisconnect } from "wagmi";
import { contractAbi, contractAddress } from "../utils/constants";

function Home() {
  const { address, isConnected } = useAccount();
  const { connect } = useConnect({
    connector: new InjectedConnector(),
  });
  const { disconnect } = useDisconnect();
  const handleProvider = () => {
    if (window.ethereum) {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      console.log(`Provider =>`, provider);
      console.log(`Signer =>`, signer);
      const contract = new ethers.Contract(
        contractAddress,
        contractAbi,
        signer
      );
      console.log(`Contract =>`, contract);
    }
  };
  const getContract = async () => {
    if (window.ethereum) {
      const provider = new ethers.providers.Web3Provider(window.ethereum);
      const signer = provider.getSigner();
      const contract = new ethers.Contract(
        "83a5d95c84c9dcc48770ccc5b741e36da46d68f435ff27d646408d44065412b6",
        contractAbi,
        signer
      );
      return contract;
    }
  };
  const callContract = async () => {
    const contract = await getContract();
    if (contract) {
      const parsedAmount = ethers.utils.parseEther("0.00012");
      const response = await contract.addToBlockchain(
        "0xB965ad25Ccbd6A1e63aE5e98AAe93FAb37Bc5DE4",
        parsedAmount,
        "A Message",
        "Some Keyword"
      );
      console.log(`Response from calling contract => `, response);
    }
  };

  useEffect(() => {
    handleProvider();
  }, []);
  return (
    <div className="h-screen flex flex-col items-center justify-center gap-12">
      <p>{address}</p>
      <button
        className="px-5 py-3 bg-black text-white"
        onClick={() => connect()}
      >
        Connect
      </button>
      <button
        className="px-5 py-3 bg-black text-white"
        onClick={() => disconnect()}
      >
        Disconnect
      </button>
      <button
        className="px-5 py-3 bg-black text-white"
        onClick={async () => await callContract()}
      >
        Call Contract
      </button>
    </div>
  );
}

export default Home;
