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
- Access to the `stark-cairo-nodes` repository: [GitHub Repo](https://github.com/KaizeNodeLabs/stark-cairo-nodes).

## 🔌 2. Installing the Starknet Plugin
Follow these steps to install the `Starknet` plugin on Remix IDE:

1. Open **Remix IDE**.
2. Navigate to the **Plugin Manager**.
3. Search for **Starknet** and click "Activate".
4. Click to **Install** the plugin.

Once activated, you will see a Starknet tab in Remix.

## 🛠️ 3. Compiling Smart Contracts
To compile contracts in Remix using the Starknet plugin:

**Open Remix IDE** and create a new workspace:
   - In the **File Explorer**, click **Create** → **New Workspace**.
   - Name the workspace as needed.

2. **Create a New File**:
   - Within the new workspace, click **New File**.
   - Name the file `hello_world.cairo`.

3. **Copy and Paste the Contract Code**:
   - Go to the [`stark-cairo-nodes`](https://github.com/KaizeNodeLabs/stark-cairo-nodes) repository.
   - Navigate to `contracts/helloWorld/hello_world.cairo`.
   - Copy the contents of the file.
   - Paste the code into the new `hello_world.cairo` file in Remix.

4. **Compile the Contract**:
   - Select the `hello_world.cairo` file in the File Explorer.
   - Open the **Starknet** tab in Remix IDE.
   - Click **Compile** to generate the compiled artifacts.

#### **Example Contract: `helloWorld`**
Here is the `HelloWorld` contract used in this guide:

```rust
#[starknet::interface] 
pub trait ISimpleHelloWorld<TContractState> {
    fn get_hello_world(self: @TContractState) -> felt252;
    fn set_hello_world(ref self: TContractState);
}

#[starknet::contract]
pub mod SimpleHelloWorld {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    #[storage]
    struct Storage {
        stored_data: felt252
    }

    #[abi(embed_v0)]
    impl SimpleHelloWorld of super::ISimpleHelloWorld<ContractState> {
        fn set_hello_world(ref self: ContractState) {
            self.stored_data.write('Hello world!')
        }

        fn get_hello_world(self: @ContractState) -> felt252 {
            self.stored_data.read()
        }
    }
}
```

> **Note**: Ensure the contract is error-free before proceeding.

## 🚢 4. Deploying Contracts
Steps to deploy a compiled contract:

1. Open the Starknet `tab` in Remix IDE.
2. Navigate to the **Deployment** section.
3. Connect your Starknet wallet (Argent X).
4. Upload the compiled contract and click **Deploy**.
5. Confirm the transaction in your wallet.

After deployment, you will receive a **Contract Address**.

---

## 📄 5. Example Deployment
**To demonstrate, we deploy the `HelloWorld` from this repository:**

1. **Compile the Contract:** 
```bash
Open the `HelloWorld` contract in Remix and click Compile in the Starknet tab.
```

2. **Connect Your Wallet:** 
```bash
Use the Connect Wallet button to link your Starknet wallet (Argent X).
```

3. **Deploy the Contract:** 
```bash
In the Deployment section of the Starknet tab, select the compiled SimpleHelloWorld contract and click Deploy.
```

4. **Deployment Result:** Once the deployment succeeds, a message will show a contract address:
```rust
Contract address: 0x0123456789ABCDEF
```

5. **Interact with the Contract:**
```bash
 Use the functions set_hello_world and get_hello_world to test the contract.
 ```


## 🔗 6. Troubleshooting Tips
- **Compilation errors**: 
  - Ensure the contract is written in the correct Starknet-compatible syntax.
  - Update the Starknet plugin to the latest version if needed.

- **Wallet connection issues**:
  - Refresh both Remix IDE and your wallet extension.
  - Confirm that your wallet is connected to the correct network (Testnet or Mainnet).
  
- **Deployment failure**:
  - Check if you have sufficient balance for deployment fees.
  - Double-check your network configuration in the wallet.

---

## 📝 Additional Notes
- Reference this guide in the root `README.md` for clarity.
- Follow our guidelines for further contributions.

---

#### **Happy Coding!** 🎄🎅