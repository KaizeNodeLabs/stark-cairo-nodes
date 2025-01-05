fn is_even(number: u32) -> bool {
    number % 2 == 0
}

fn is_odd(number: u32) -> bool {
    number % 2 != 0
}

fn main() {
    let number_1: u32 = 4;
    let number_2: u32 = 5;

    if is_even(number_1) {
    println!("condition was true and number_1 = {}", is even!);
    }
    else {
     println!("condition was false and number_1 = {}", is odd!);
    }

    if is_odd(number_2) {
    println!("condition was true and number_2 = {}", is odd!);
    }
    else {
     println!("condition was false and number_2 = {}", is even!);
    }
}
