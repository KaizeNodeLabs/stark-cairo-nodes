fn is_even(number: i32) -> bool {
    number % 2 == 0
}

fn is_odd(number: i32) -> bool {
    number % 2 != 0
}

fn main() {
    let number_1: i32 = -4;
    let number_2: i32 = 5;

    if is_even(number_1) {
        println!("{number_1} is even !");
    } else {
        println!("{number_1} is odd !");
    }

    if is_odd(number_2) {
        println!("{number_2} is odd !");
    } else {
        println!("{number_2} is even !");
    }
}
