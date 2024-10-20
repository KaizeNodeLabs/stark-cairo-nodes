%lang starknet

@contract_interface
namespace HelloWorld:
    func __constructor__() -> ():
    end

    func say_hello() -> (res: felt):
    end
end

@external
func __constructor__() -> ():
    return ()
end

@external
func say_hello() -> (res: felt):
    return (res='Hello, World!'.to_felt())
end