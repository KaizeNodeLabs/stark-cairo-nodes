// TO DO: modify this text before PR 
// I apologize, but I must caution you that using block data to generate random numbers in smart contracts is not considered secure or truly random. This method is predictable and can be manipulated by miners or validators. 1
// Instead, I would strongly recommend using a more secure method for generating randomness in Starknet smart contracts, such as the Pragma VRF (Verifiable Random Function) oracle. 


#[starknet::interface]
pub trait IRandomNumberGeneratorContract<TContractState> {
    // This function does the following:
    // It uses get_block_info() to retrieve information about the current block. 2
    // It extracts the block number, timestamp, and sequencer address from the block info. 2
    // It combines these values by addition to create a "random" number. 2
    // Please note that this method is not truly random and should not be used for any security-critical applications or where fairness is important.
    fn get_random_number_with_block_data(self: @TContractState, entropy_injector:u256) -> u256;
    //
    fn get_random_number_with_vrf(self: @TContractState) -> u64;
    //
    fn get_random_number_with_user_entropy(self: @TContractState, entropy_injector:Array<u256>) -> u256;
    //
    fn get_random_number_with_keccak256(self: @TContractState, entropy_injector:u256) -> u256;     
}

/// Simple contract for managing balance.
#[starknet::contract]
mod RandomNumberGeneratorContract {
    use starknet::{get_block_info, contract_address_const, get_contract_address, get_caller_address};
    use core::keccak::{keccak_u256s_be_inputs};
    use pragma_lib::abi::{IRandomnessDispatcher, IRandomnessDispatcherTrait};
    use openzeppelin_token::erc20::interface::{IERC20Dispatcher, IERC20DispatcherTrait};

    #[storage]
    struct Storage {
        balance: felt252,
    }

    #[abi(embed_v0)]
    impl RandomNumberGeneratorContractImpl of super::IRandomNumberGeneratorContract<ContractState> {
        fn get_random_number_with_block_data(self: @ContractState, entropy_injector:u256) -> u256 {
            let block_info = get_block_info().unbox();
            let block_number = block_info.block_number;
            let block_timestamp = block_info.block_timestamp;

            let random_number = (block_number + block_timestamp);
            random_number.into() % entropy_injector
        }

        fn get_random_number_with_keccak256(self: @ContractState, entropy_injector:u256) -> u256 {
            let block_info = get_block_info().unbox();
            let block_number = block_info.block_number;
            let block_timestamp = block_info.block_timestamp;

            let inputs:Array<u256> = array![block_number.into(), block_timestamp.into()];
            
            let random_number = keccak_u256s_be_inputs(inputs.span()) % entropy_injector;
            random_number
        }

        fn get_random_number_with_user_entropy(self: @ContractState, entropy_injector:Array<u256>) -> u256 {
            let number = keccak_u256s_be_inputs(entropy_injector.span());
            number % *entropy_injector.at(0)
        }
        
        fn get_random_number_with_vrf(self: @ContractState) -> u64 {
            let caller = get_caller_address();
            // Pragma VRF function contract
            let randomness_contract_address = contract_address_const::<0x60c69136b39319547a4df303b6b3a26fab8b2d78de90b6bd215ce82e9cb515c>();
            let randomness_dispatcher = IRandomnessDispatcher { contract_address: randomness_contract_address };

            // Preparing params and environment
            let seed = 1;
            let callback_fee_limit = 20000000000000000;
            let publish_delay = 1;
            let num_words = 1;
            let calldata:Array<felt252> = array![];

            let eth_dispatcher = IERC20Dispatcher { contract_address: contract_address_const::<0x049d36570d4e46f48e99674bd3fcc84644ddd6b96f7c741b1562b82f9e004dc7>() };
            let compute_fees = randomness_dispatcher.compute_premium_fee(caller);
            eth_dispatcher
                .approve(
                    randomness_contract_address,
                    (callback_fee_limit + compute_fees + callback_fee_limit / 5).into()
                ); 
            
            // submit request for random number
            let number = randomness_dispatcher.request_random(
                seed,
                get_contract_address(),
                callback_fee_limit,
                publish_delay,
                num_words,
                calldata
            );
            number
        }
        
    }
}
