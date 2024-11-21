fn iterative_fibonacci(n: u128) -> u128 {
    if (n < 2) {
        return n;
    }
    let mut a: u128 = 0;
    let mut b: u128 = 1;
    let mut i: u128 = 2;

    while i <= n {
        let temp = a + b;
        a = b;
        b = temp;
        i += 1;
    };
    b
}

// For pedagogical purposes only. This recursive solution has O(2^n) complexity because
// each call creates two more calls, leading to exponential redundant calculations.
fn recursive_fibonacci(n: u128) -> u128 {
    if (n < 2) {
        return n;
    }
    (recursive_fibonacci(n - 1) + recursive_fibonacci(n - 2))
}

fn main() {
    let mut n: u128 = 80;
    let result = iterative_fibonacci(n);
    println!("fibonacci of {n} is {result}");

    n = 3;
    let result = recursive_fibonacci(n);
    println!("fibonacci of {n} is {result}");
}
