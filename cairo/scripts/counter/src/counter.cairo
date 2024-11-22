#[starknet::interface]
pub trait ICounter<TContractState> {
    fn get_count(self: @TContractState) -> u64;
    fn increase_count(ref self: TContractState);
    fn decrease_count(ref self: TContractState);
}

#[starknet::contract]
pub mod Counter {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    #[storage]
    struct Storage {
        count: u64,
    }

    #[abi(embed_v0)]
    impl Counter of super::ICounter<ContractState> {
        fn get_count(self: @ContractState) -> u64 {
            self.count.read()
        }

        fn increase_count(ref self: ContractState) {
            let current_count: u64 = self.count.read();
            self.count.write(current_count + 1);
        }

        fn decrease_count(ref self: ContractState) {
            let current_count: u64 = self.count.read();
            self.count.write(current_count - 1);
        }

    }
}