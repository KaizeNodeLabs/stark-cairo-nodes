use starknet::{
    ContractAddress, 
    testing::{set_caller_address, set_block_timestamp},
};
use core::test::test_utils::assert_eq;
use core::traits::Into;
use core::option::OptionTrait;

use crowdfunding::crowdfunding::{
    Crowdfunding, 
    CrowdfundingContract, 
    CampaignState, 
    ICrowdfundingDispatcher, 
    ICrowdfundingDispatcherTrait
};

fn deploy_contract() -> ICrowdfundingDispatcher {
    let contract = Crowdfunding::deploy();
    contract
}

fn create_address() -> ContractAddress {
    ContractAddress::from(0x123)
}

#[test]
fn test_create_campaign() {
    // Set up the test environment
    let contract = deploy_contract();
    let creator = create_address();
    set_caller_address(creator);

    // Defining the campaign parameters
    let campaign_id = 1;
    let funding_goal = 1000_u64;
    let current_time = 1000_u64;
    let deadline = current_time + 86400_u64;
    
    // Establishing the current time
    set_block_timestamp(current_time);

    // Creating the campaign
    contract.create_campaign(campaign_id, funding_goal, deadline);

    // Verify that the campaign was created successfully
    let campaign = contract.get_campaign(campaign_id);
    assert_eq!(campaign.funding_goal, funding_goal, "Incorrect funding goal");
    assert_eq!(campaign.deadline, deadline, "Incorrect deadline");
    assert_eq!(campaign.state, CampaignState::Active, "Incorrect state");
    assert_eq!(campaign.creator, creator, "Incorrect creator");
}

#[test]
fn test_contribute_to_campaign() {
    // Set up the test environment
    let contract = deploy_contract();
    let creator = create_address();
    let contributor = ContractAddress::from(0x456);

    // Create a campaign
    set_caller_address(creator);
    let campaign_id = 1;
    let funding_goal = 1000_u64;
    let current_time = 1000_u64;
    let deadline = current_time + 86400_u64;
    
    set_block_timestamp(current_time);
    contract.create_campaign(campaign_id, funding_goal, deadline);

    // Simulate a contribution
    set_caller_address(contributor);
    contract.contribute(campaign_id);

    // Verify that the contribution was successful
    let contribution = contract.get_contribution(campaign_id, contributor);
    assert_eq!(contribution, 100_u64, "Incorrect contribution amount"); //100 is the default contribution amount
}

#[test]
fn test_finalize_successful_campaign() {
    // Set up the test environment
    let contract = deploy_contract();
    let creator = create_address();
    let contributor1 = ContractAddress::from(0x456);
    let contributor2 = ContractAddress::from(0x789);

    // Create a campaign
    set_caller_address(creator);
    let campaign_id = 1;
    let funding_goal = 1000_u64;
    let current_time = 1000_u64;
    let deadline = current_time + 86400_u64;
    
    set_block_timestamp(current_time);
    contract.create_campaign(campaign_id, funding_goal, deadline);

    // Simulate contributions that reach the goal
    set_caller_address(contributor1);
    contract.contribute(campaign_id);
    
    set_caller_address(contributor2);
    contract.contribute(campaign_id);

    // Advance the time beyond the deadline
    set_block_timestamp(deadline + 1);

    // Finalize the campaign
    contract.finalize_campaign(campaign_id);

    // Verify that the campaign was successful
    let campaign = contract.get_campaign(campaign_id);
    assert_eq!(campaign.state, CampaignState::Successful, "Campaign should be successful");
}

#[test]
fn test_refund_failed_campaign() {
    // Set up the test environment
    let contract = deploy_contract();
    let creator = create_address();
    let contributor = ContractAddress::from(0x456);

    // Create a campaign
    set_caller_address(creator);
    let campaign_id = 1;
    let funding_goal = 1000_u64;
    let current_time = 1000_u64;
    let deadline = current_time + 86400_u64;
    
    set_block_timestamp(current_time);
    contract.create_campaign(campaign_id, funding_goal, deadline);

    // Simulate a contribution that does not reach the goal
    set_caller_address(contributor);
    contract.contribute(campaign_id);

    // Advace the time beyond the deadline
    set_block_timestamp(deadline + 1);

    // Finialize the campaign
    contract.finalize_campaign(campaign_id);

    // Verify that the campaign failed
    let campaign = contract.get_campaign(campaign_id);
    assert_eq!(campaign.state, CampaignState::Failed, "Campaign should have failed");

    // Request a refund
    set_caller_address(contributor);
    contract.refund_contribution(campaign_id);

    // Verifiy that the refund was successful
    let contribution = contract.get_contribution(campaign_id, contributor);
    assert_eq!(contribution, 0_u64, "Contribution should be 0 after refund");
}

#[test]
#[should_panic(expected: ('Campaign already exists'))]
fn test_create_duplicate_campaign() {
    let contract = deploy_contract();
    let creator = create_address();
    set_caller_address(creator);

    let campaign_id = 1;
    let funding_goal = 1000_u64;
    let current_time = 1000_u64;
    let deadline = current_time + 86400_u64;
    
    set_block_timestamp(current_time);

    // Create a campaign
    contract.create_campaign(campaign_id, funding_goal, deadline);
    
    // try to create the same campaign again
    contract.create_campaign(campaign_id, funding_goal, deadline);
}
