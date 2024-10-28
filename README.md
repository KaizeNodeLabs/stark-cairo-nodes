# stark-cairo-nodes 🔗💡

Set of scripts written in Cairo/Starknet to learn and teach newcomers the ecosystem.

## Table of Contents
- [Overview](#overview)
- [Steps to Build and Run Cairo Scripts](#steps-to-build-and-run-cairo-scripts)
  - [1. Set Up Your Environment](#1-set-up-your-environment)
  - [2. Navigate to the Scripts Directory](#2-navigate-to-the-scripts-directory)
  - [3. Build the Project](#3-build-the-project)
  - [4. Run the Script](#4-run-the-script)
## Overview

**stark-cairo-nodes** is a collection of educational scripts built using the Cairo programming language, specifically designed for the Starknet ecosystem. These scripts are ideal for both beginners and intermediate developers looking to deepen their understanding of Cairo and Starknet concepts.

## Steps to Build and Run Cairo Scripts

### 1. **Set Up Your Environment**

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

### 2. **Navigate to the Scripts Directory**

First, navigate to the general cairo/scripts/ directory:

```bash
cd cairo/scripts/
```

Then, navigate to the specific script's directory you want to run. For example, if the script you want to execute is in a folder named example_script, navigate into that directory:

```bash
cd example_script
```

### 3. **Build the Project**

Build the project with the following command:

```bash
scarb build
```

### 4. **Run the Script**

To execute the main function of the script, use:

```bash
scarb cairo-run
```

Give us a star! ⭐
