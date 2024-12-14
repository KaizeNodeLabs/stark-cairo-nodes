# 🚀 Deployment Guide for Starknet Smart Contracts by Stark Cairo Nodes

This guide provides step-by-step instructions for deploying smart contracts on Starknet using **Remix IDE**. It covers the installation, compilation, and deployment processes for proper use of the IDE.

---

## 📚 Table of Contents
1. [⚙️ Prerequisites](#prerequisites)
2. [🔌 Installing the Starknet Plugin](#installing-the-starknet-plugin)
3. [🛠️ Compiling Smart Contracts](#compiling-smart-contracts)
4. [🚢 Deploying Contracts](#deploying-contracts)
5. [📄 Example Deployment](#example-deployment)
6. [🔗 Troubleshooting Tips](#troubleshooting-tips)

---

## ⚙️ 1. Prerequisites
Ensure you have the following before starting:
- **Remix IDE**: [Access Remix IDE](https://remix.ethereum.org/)
- Starknet Wallet (Argent X or Braavos).
- Node.js and npm installed for local testing.
- Access to this repository's contract files.

## 🔌 2. Installing the Starknet Plugin
Follow these steps to install the `Starknet` plugin on Remix IDE:

1. Open **Remix IDE**.
2. Navigate to the **Plugin Manager**.
3. Search for **Starknet** and click "Activate".

Once activated, you will see a Starknet tab in Remix.

## 🛠️ 3. Compiling Smart Contracts
To compile contracts in Remix using the Starknet plugin:

1. Open the **Starknet** tab.
2. Select the contract file (`contract.cairo`) from the repository.
3. Click **Compile** to generate the compiled artifacts.

**Example file for compilation:**
```cairo
// contracts/ExampleContract.cairo
%lang starknet

@external
func example_function(){
    return ();
}
```

> **Note**: Ensure the contract is error-free before proceeding.

## 🚢 4. Deploying Contracts
Steps to deploy a compiled contract:

1. Open the **Starknet** tab.
2. Navigate to the **Deployment** section.
3. Connect your Starknet wallet (Argent X).
4. Upload the compiled contract and click **Deploy**.
5. Confirm the transaction in your wallet.

After deployment, you will receive a **Contract Address**.

## 📄 5. Example Deployment
To demonstrate, we deploy the `ExampleContract.cairo` from this repository:

1. Compile the contract:
   ```bash
   starknet-compile contracts/ExampleContract.cairo --output example_compiled.json --abi example_abi.json
   ```
2. Deploy the contract:
   ```bash
   starknet deploy --contract example_compiled.json --network testnet
   ```
3. Result:
   ```plaintext
   Contract address: 0x0123456789ABCDEF...
   ```

## 🔗 6. Troubleshooting Tips
- **Compilation errors**: Check syntax and ensure you are using a compatible Starknet version.
- **Wallet connection issues**: Refresh the wallet extension and Remix IDE.
- **Deployment failure**: Verify your wallet balance and network configuration.

---

## 📝 Additional Notes
- Reference this guide in the root `README.md` for clarity.
- Follow our guidelines for further contributions.

---

#### **Happy Coding!** 🎄🎅