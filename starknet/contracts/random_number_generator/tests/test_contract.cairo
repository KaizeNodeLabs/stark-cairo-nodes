use starknet::{ContractAddress, contract_address_const};

use snforge_std::{declare, ContractClassTrait, DeclareResultTrait, start_cheat_caller_address };
use random_number_generator::IRandomNumberGeneratorContractDispatcher;
use random_number_generator::IRandomNumberGeneratorContractDispatcherTrait;

fn deploy_contract() -> ContractAddress {
    let contract = declare("RandomNumberGeneratorContract").unwrap().contract_class();
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address
}

#[test]
fn test_get_random_number_with_block_data() {
    let contract_address = deploy_contract();
    let dispatcher = IRandomNumberGeneratorContractDispatcher { contract_address };
    let number = dispatcher.get_random_number_with_block_data();
    println!("number --> {}", number);
}

#[test]
// #[fork(url: "https://starknet-sepolia.public.blastapi.io/rpc/v0_7", block_number: 388337)]
fn get_random_number_with_block_data() {
    let contract_address = deploy_contract();
    let dispatcher = IRandomNumberGeneratorContractDispatcher { contract_address };
    
    start_cheat_caller_address(contract_address, contract_address_const::<0x0416575467BBE3E3D1ABC92d175c71e06C7EA1FaB37120983A08b6a2B2D12794>());
    let number = dispatcher.get_random_number_with_vrf();
    println!("number --> {}", number);
}