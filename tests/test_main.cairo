%lang starknet
from src.main import balance, increase_balance
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import (get_caller_address, get_contract_address)

@external
func test_contract_balance_was_not_set{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}(){
    let (address_this) = get_contract_address();
    let (contract_balance) = balance.read(address_this);

    assert contract_balance = 0;

    return ();
}

@external
func test_increase_balance{syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*}() {
    let (msg_sender) = get_caller_address();
    let (result_before) = balance.read(msg_sender);
    assert result_before = 0;

    increase_balance(42);

    let (result_after) = balance.read(msg_sender);
    assert result_after = 42;
    return ();
}

@external
func test_cannot_increase_balance_with_negative_value{
    syscall_ptr: felt*, range_check_ptr, pedersen_ptr: HashBuiltin*
}() {
    let (msg_sender) = get_caller_address();
    let (result_before) = balance.read(msg_sender);
    assert result_before = 0;

    %{ expect_revert("TRANSACTION_FAILED", "Amount must be positive") %}
    increase_balance(-42);

    return ();
}
