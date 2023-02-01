%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import (get_caller_address, get_contract_address)

@storage_var
func balance(account: felt) -> (res: felt) {
}

@external
func increase_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    amount: felt
) {
    let (caller) = get_caller_address(); //msg.sender

    with_attr error_message("Amount must be positive. Got: {amount}.") {
        assert_nn(amount); // assert not negative ensures that the amount passed is not negative else the above error message is thrown.
    } // think of this like the require statement in solidity

    let (caller_prev_balance) = balance.read(caller);
    let new_balance = caller_prev_balance + amount;
    balance.write(caller, new_balance); // when writing t key comes first followed by the new value
    return ();
}

@view
func get_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(account: felt) -> (res: felt) {
    let (res) = balance.read(account);
    return (res,);
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    let (this_contract) = get_contract_address();
    balance.write(this_contract, 10000);
    return ();
}
