%lang starknet
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import (get_caller_address, get_contract_address)

struct Details {
    name: felt,
    age: felt,
    gender: felt,
}

@storage_var
func admin() -> (res: felt) {
}

@storage_var
func student_details(student_address: felt) -> (details: Details) {
}

@view
func get_details{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(_student_address: felt) -> (details: Details){
    let (details) = student_details.read(_student_address);
    return (details,);
}

@view
func get_name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(_student_address: felt) -> (name: felt){
    let (details) = student_details.read(_student_address);
    let name = details.name;
    return (name,);
}

@view
func get_admin_name{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (address: felt){
    let (admin_address) = admin.read();
    return (admin_address,);
}

@external
func store_details{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    _name: felt, _age: felt, _gender: felt
) {
    let (msg_sender) = get_caller_address();
    let new_detail = Details(name=_name, age=_age, gender=_gender);
    student_details.write(msg_sender, new_detail);

    return ();
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(_admin_address: felt){
    admin.write(_admin_address);
    return ();
}