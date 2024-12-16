# Counter Access Control Contract Documentation

## Overview

This contract provides a counter functionality with limited access control functionalities.
Authorized owners can increase or decrease the value displayed by the counter,
while limiting the use in order to avoid any changes by other persons who may have access to the contract.

## Key Features

- Increment and decrement counter values
- Get current counter value
- Retrieve owner address
- Add new owners

## Usage

Here's a breakdown of how to use the **CounterAccessControl** contract:

**The contract has five (5) key functions that perform various operations**

1. **_Increase Counter:_**
   _fn increase_counter(ref self: TContractState)_

   - Increases the counter value by 1.
   - Only the owner can all the contract.

2. **_Decrease Counter:_**
   _fn decrease_counter(ref self: TContractState)_

   - Decreases the counter value by 1.
   - Only the owner can all the contract.

3. **_Get Current Counter Value:_**
   _fn get_counter(self: @TContractState) -> u32_

   - Retrieves the current value of the counter without modifying it.

4. **_Get Owner Address:_**
   _fn get_owner(self: @TContractState) -> ContractAddress_

   - Returns the address of the current owner of the contract.

5. **_Add New Owner:_**
   _fn add_new_owner(ref self: TContractState, new_owner: ContractAddress)_
   - Changes the ownership of the contract to a new address.
   - Only callable by the current owner.

## Events

- `CounterIncreased`: Emitted when the counter is increased.
- `CounterDecreased`: Emitted when the counter is decreased.
- `OwnerChanged`: Emitted when the contract owner is updated.

## Contract Structure

- `counter`: Saves the current value stored in the counter – unsigned u32
- `owner`: Saves the address of the contract owner so that anyone can view the contract owner’s address (ContractAddress)

## Security Considerations

- Counter can be changed only by the owner

- Eliminates zero address exploits

- Prevents unauthorized addition of new owners to prevent unauthorized access

## Use Cases

- A counter with an access control mechanism, restricting unauthorized users
- Basic voting system
- Resource allocation tracker

## Upgrades

- This contract supports upgrades using [proxy pattern](https://docs.openzeppelin.com/upgrades/4.8/proxies)

- Refer to this link for all the necessary installations [asdf documentation](https://asdf-vm.com/guide/getting-started.html)
