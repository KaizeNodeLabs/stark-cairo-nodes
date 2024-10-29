#[starknet::interface]
pub trait ISimpleHelloWorld<TContractState> {
    fn get_hello_world(self: @TContractState) -> ByteArray;
    fn set_hello_world(self: @TContractState);
}

#[starknet::contract]
pub mod SimpleHelloWorld {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};
    #[storage]
    struct Storage {
        stored_data: ByteArray
    }

    #[abi(embed_v0)]
    impl SimpleHelloWorld of super::ISimpleHelloWorld<ContractState> {
        fn set_hello_world(self: @ContractState) {
            self.stored_data.write("Hello world!")
        }

        fn get_hello_world(self: @ContractState) -> ByteArray {
            self.stored_data.read()
        }
    }
}
