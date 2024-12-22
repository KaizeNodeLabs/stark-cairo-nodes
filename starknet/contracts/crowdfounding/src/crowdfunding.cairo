#[starknet::interface]
pub trait ICrowdfunding<TContractState> {
    fn create_campaign(
        ref self: TContractState,
        campaign_id: felt252,
        funding_goal: u64,
        deadline: u64,
    );
    fn contribute(ref self: TContractState, campaign_id: felt252);
    fn finalize_campaign(ref self: TContractState, campaign_id: felt252);
    fn withdraw_funds(ref self: TContractState, campaign_id: felt252);
    fn refund_contribution(ref self: TContractState, campaign_id: felt252);
    fn get_campaign(self: @TContractState, campaign_id: felt252) -> Campaign;
    fn get_contribution(self: @TContractState, campaign_id: felt252, contributor: ContractAddress) -> u64;
}

#[starknet::contract]
mod Crowdfunding {
    use core::starknet::{
        ContractAddress,
        get_block_timestamp,
        get_caller_address,
    };
    use core::option::OptionTrait;
    use core::traits::Into;

    #[derive(Drop, Serde, starknet::Store)]
    struct Campaign {
        creator: ContractAddress,
        funding_goal: u64,
        deadline: u64,
        funds_raised: u64,
        state: CampaignState,
    }

    #[storage]
    struct Storage {
        campaigns: Map<felt252, Campaign>,
        contributions: Map<(felt252, ContractAddress), u64>,
    }

    #[derive(Copy, Drop, Serde, starknet::Store, PartialEq)]
    enum CampaignState {
        Active,
        Successful,
        Failed,
    }

    #[abi_impl]
    impl ICrowdfunding<ContractState> of Crowdfunding {
        fn create_campaign(
            ref self: ContractState,
            campaign_id: felt252,
            funding_goal: u64,
            deadline: u64,
        ) {
            let caller = get_caller_address();
            let current_timestamp = get_block_timestamp();

            assert!(!self.campaigns.contains(campaign_id), "Campaign already exists");
            assert!(deadline > current_timestamp, "Deadline must be in the future");

            let new_campaign = Campaign {
                creator: caller,
                funding_goal,
                deadline,
                funds_raised: 0,
                state: CampaignState::Active,
            };
            self.campaigns.insert(campaign_id, new_campaign);
        }

        fn contribute(ref self: ContractState, campaign_id: felt252) {
            let caller = get_caller_address();
            let current_timestamp = get_block_timestamp();
            let mut campaign = self.campaigns.get(campaign_id);

            assert!(campaign.state == CampaignState::Active, "Campaign is not active");
            assert!(current_timestamp <= campaign.deadline, "Campaign deadline has passed");

            let contribution_amount = get_contribution_amount();

            campaign.funds_raised += contribution_amount;
            self.campaigns.insert(campaign_id, campaign);
            
            let previous_contribution = match self.contributions.get((campaign_id, caller)) {
                Option::Some(amount) => amount,
                Option::None => 0,
            };
            
            self.contributions.insert((campaign_id, caller), previous_contribution + contribution_amount);
        }

        fn finalize_campaign(ref self: ContractState, campaign_id: felt252) {
            let current_timestamp = get_block_timestamp();
            let mut campaign = self.campaigns.get(campaign_id);

            assert!(campaign.state == CampaignState::Active, "Campaign is not active");
            assert!(current_timestamp > campaign.deadline, "Campaign deadline has not passed yet");

            campaign.state = if campaign.funds_raised >= campaign.funding_goal {
                CampaignState::Successful
            } else {
                CampaignState::Failed
            };
            
            self.campaigns.insert(campaign_id, campaign);
        }

        fn withdraw_funds(ref self: ContractState, campaign_id: felt252) {
            let caller = get_caller_address();
            let mut campaign = self.campaigns.get(campaign_id);

            assert!(campaign.state == CampaignState::Successful, "Campaign is not successful");
            assert!(caller == campaign.creator, "Only the creator can withdraw funds");

            transfer_funds(caller, campaign.funds_raised);

            campaign.funds_raised = 0;
            self.campaigns.insert(campaign_id, campaign);
        }

        fn refund_contribution(ref self: ContractState, campaign_id: felt252) {
            let caller = get_caller_address();
            let campaign = self.campaigns.get(campaign_id);

            assert!(campaign.state == CampaignState::Failed, "Campaign is not failed");

            let contribution_amount = match self.contributions.get((campaign_id, caller)) {
                Option::Some(amount) => amount,
                Option::None => 0,
            };

            if contribution_amount > 0 {
                transfer_funds(caller, contribution_amount);
                self.contributions.remove((campaign_id, caller));
            }
        }

        fn get_campaign(self: @ContractState, campaign_id: felt252) -> Campaign {
            let campaign = self.campaigns.get(campaign_id);
            
            assert!(self.campaigns.contains(campaign_id), "Campaign does not exist");
            
            campaign
        }

        fn get_contribution(self: @ContractState, campaign_id: felt252, contributor: ContractAddress) -> u64 {
            match self.contributions.get((campaign_id, contributor)) {
                Option::Some(amount) => amount,
                Option::None => 0_u64
            }
        }
    }

    // Auxuliar functions
    fn get_contribution_amount() -> u64 {
        //Implement the logic to get the contribution amount
        // For now we return a fixed value for example
        100
    }

    fn transfer_funds(to: ContractAddress, amount: u64) {
        //Implement the logic to transfer funds
        // This function will need to use the Starknet transfer primitives
    }
}
