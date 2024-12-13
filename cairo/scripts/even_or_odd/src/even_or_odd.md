## Program to check if a number is even or odd number
The main purpose of the code base above is to demonstrate how to check if a number is even or odd using simple boolean logic in cairo programming language.

```
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

```
### Check for even number
```
fn is_even(number: i32) -> bool {
    number % 2 == 0
}

```
This defines a function named is_even that takes an integer parameter number of type i32 and returns a boolean value. The function checks if the input number is even by verifying if it's divisible by 2 without a remainder.

### check for odd number
```
fn is_odd(number: i32) -> bool {
    number % 2 != 0
}

```
This defines another function named is_odd that takes an integer parameter number of type i32 and returns a boolean value. It checks if the input number is odd by verifying if it's not divisible by 2 without a remainder.

### main 
```
fn main() {

```
This line starts the main function, which is the entry point of the program.

## Declare two integer variables
```
let number_1: i32 = -4;
let number_2: i32 = 5;

```
These lines declare two integer variables, number_1 and number_2, both of type i32. They are initialized with values -4 and 5, respectively.


```
if is_even(number_1) {
    println!("{number_1} is even !");
}
else {
    println!("{number_1} is odd !");
}

```
This block uses the is_odd function to check if number_2 is odd. If true, it prints that number_2 is odd; otherwise, it prints that number_2 is even.
The code demonstrates the use of boolean expressions and conditional statements in cairo to determine whether numbers are even or odd.

