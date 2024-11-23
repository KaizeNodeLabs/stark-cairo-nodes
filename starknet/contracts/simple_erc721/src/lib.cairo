#[starknet::contract]
pub mod QuestNFT {
    use openzeppelin::token::erc721::ERC721Component;
    use openzeppelin::token::erc721::interface::IERC721Metadata;
    use starknet::ContractAddress;

    component!(path: ERC721Component, storage: erc721, event: ERC721Event);

    #[abi(embed_v0)]
    impl ERC721Impl = ERC721Component::ERC721Impl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721CamelOnly = ERC721Component::ERC721CamelOnlyImpl<ContractState>;
    #[abi(embed_v0)]
    impl ERC721MetadataCamelOnly =
        ERC721Component::ERC721MetadataCamelOnlyImpl<ContractState>;

    impl InternalImpl = ERC721Component::InternalImpl<ContractState>;

    #[storage]
    struct Storage {
        #[substorage(v0)]
        erc721: ERC721Component::Storage,
        nft_count: u256,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        #[flat]
        ERC721Event: ERC721Component::Event,
    }


    #[constructor]
    fn constructor(
        ref self: ContractState, name: ByteArray, symbol: ByteArray, owner: ContractAddress
    ) {
        let base_uri = "";
        self.erc721.initializer(name, symbol, base_uri);
    }

    #[abi(embed_v0)]
    impl ERC721Metadata of IERC721Metadata<ContractState> {
        fn name(self: @ContractState) -> ByteArray {
            self.erc721.ERC721_name.read()
        }

        fn symbol(self: @ContractState) -> ByteArray {
            self.erc721.ERC721_symbol.read()
        }

        fn token_uri(self: @ContractState, token_id: u256) -> ByteArray {
            self.erc721._base_uri()
        }
    }

    // impl ERC721HooksEmptyImpl<ContractState> of ERC721Component::ERC721HooksTrait<ContractState> {
    //     fn before_update(
    //         ref self: ERC721Component::ComponentState<ContractState>,
    //         to: ContractAddress,
    //         token_id: u256,
    //         auth: ContractAddress
    //     ) {}

    //     fn after_update(
    //         ref self: ERC721Component::ComponentState<ContractState>,
    //         to: ContractAddress,
    //         token_id: u256,
    //         auth: ContractAddress
    //     ) {}
    // }

    // #[generate_trait]
    // impl PrivateImpl of PrivateTrait {
    //     fn _set_role(
    //         ref self: ContractState, recipient: ContractAddress, role: felt252, is_enable: bool
    //     ) {
    //         self.accesscontrol.assert_only_role(ADMIN_ROLE);
    //         assert!(role == ADMIN_ROLE || role == MINTER_ROLE, "role not enable");
    //         if is_enable {
    //             self.accesscontrol._grant_role(role, recipient);
    //         } else {
    //             self.accesscontrol._revoke_role(role, recipient);
    //         }
    //     }
    // }
}
