# stark-cairo-nodes 🔗💡

## 📖 Overview

**stark-cairo-nodes** is a collection of educational scripts built using the Cairo programming language, specifically designed for the Starknet ecosystem. These scripts are ideal for both beginners and intermediate developers looking to deepen their understanding of Cairo and Starknet concepts.

## ⚙️ Steps to Build and Run Cairo Scripts

### 1. 🛠️ **Set Up Your Environment**

- **Install Cargo**

  Scarb, the official build tool for Cairo, relies on Cargo as a dependency. Cargo is included with the Rust programming language. Follow these steps to install Cargo:

  Visit the [Rust installation page](https://doc.rust-lang.org/cargo/getting-started/installation.html) and follow the instructions to install Rust, which includes Cargo.

   Alternatively, use the appropriate command for your operating system
    - **Linux and macOS**
      ```bash
      curl https://sh.rustup.rs -sSf | sh
      ```
    - **Windows**
      Download and run the installer from the [official Rust website](https://www.rust-lang.org/tools/install).

- **Verify Cargo Installation**

  Confirm that Cargo is installed by checking its version:

```bash
cargo --version
```
   
- **Install Scarb**

  Please refer to the [asdf documentation](https://asdf-vm.com/guide/getting-started.html) to install all prerequisites

  To get started, install Scarb by running the following commands in your terminal:

```bash
  asdf plugin add scarb
  asdf install scarb latest
  asdf global scarb latest
```

- **Verify Scarb Installation**

  Confirm that Scarb is installed correctly by checking its version:

```bash
scarb --version
```

### 2. 📂 **Navigate to the Scripts Directory**

First, navigate to the general cairo/scripts/ directory:

```bash
cd cairo/scripts/
```

Then, navigate to the specific script's directory you want to run. For example, if the script you want to execute is in a folder named example_script, navigate into that directory:

```bash
cd example_script
```

### 3. 🏗️ **Build the Project**

Build the project with the following command:

```bash
scarb build
```

### 4. 🚀 **Run the Script**

To execute the main function of the script, use:

```bash
scarb cairo-run
```


## ⚙️ Steps to build and and test contracts

### 1. 🛠️ **Set Up Your Environment** 

- **Install Cargo**

  Scarb, the official build tool for Cairo, relies on Cargo as a dependency. Cargo is included with the Rust programming language. Follow these steps to install Cargo:

  Visit the [Rust installation page](https://doc.rust-lang.org/cargo/getting-started/installation.html) and follow the instructions to install Rust, which includes Cargo.

   Alternatively, use the appropriate command for your operating system
    - **Linux and macOS**
      ```bash
      curl https://sh.rustup.rs -sSf | sh
      ```
    - **Windows**
      Download and run the installer from the [official Rust website](https://www.rust-lang.org/tools/install).

- **Verify Cargo Installation**

  Confirm that Cargo is installed by checking its version:

```bash
cargo --version
```

- **Install Scarb**
Before you can build and test Cairo contracts, you need to have Scarb, the official build tool for Cairo. 
Install it with these steps:

```bash
asdf plugin add scarb
asdf install scarb latest
asdf global scarb latest
```
- **Install Install SnForge (Cairo Testing Framework)**
SnForge is the tool used to run unit tests for Cairo contracts in the Starknet ecosystem. Install it by running:

```bash
pip install snforge
```
### 2. ✅ Verify Installations
After installation, confirm that both tools are correctly installed by running:

For Scarb:

```bash
scarb --version
```

For SnForge:

```bash
snforge --version
```

### 3. 📂 Navigate to the Contract Directory
Proceed to the directory where your Cairo contract is located.

Example:

```bash
cd path/to/your/cairo-contract-directory
```

### 4. 🏗️ Compile the Contract
Use Scarb to compile your Cairo contract by running:

```bash
Copy code
scarb build
```
This will generate the necessary artifacts for your Cairo contract.

### 5. 🏃 Run Unit Tests with SnForge
Once the contract is compiled, you can run unit tests using SnForge. .

To run your contract's tests, use the following command:

```bash
snforge test
```
SnForge will automatically detect the test files in your project and run them.

### 6. 🔁 Review Test Results
After running the tests, you will see the results in your terminal. If the tests fail, the output will include details that will help you debug the issue. If everything passes, you’ll see confirmation that your contract is working as expected.

## Give us a star! ⭐
