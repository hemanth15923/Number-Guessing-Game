#include <cstdlib>
#include <ctime>
#include <iostream>
#include <limits>

int main() {
    std::srand(static_cast<unsigned int>(std::time(nullptr)));

    const int secretNumber = std::rand() % 100 + 1;
    int guess = 0;
    int attempts = 0;

    std::cout << "=== Guess The Number Game ===\n";
    std::cout << "I have selected a number from 1 to 100.\n";
    std::cout << "Try to guess it!\n\n";

    while (guess != secretNumber) {
        std::cout << "Enter your guess: ";

        if (!(std::cin >> guess)) {
            std::cout << "Invalid input. Please enter a whole number.\n";

            std::cin.clear();
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
            continue;
        }

        attempts++;

        if (guess < 1 || guess > 100) {
            std::cout << "Please enter a number between 1 and 100.\n";
        } else if (guess < secretNumber) {
            std::cout << "Too low. Try again.\n";
        } else if (guess > secretNumber) {
            std::cout << "Too high. Try again.\n";
        } else {
            std::cout << "\nCongratulations! You guessed the number.\n";
            std::cout << "Attempts taken: " << attempts << '\n';
        }
    }

    return 0;
}
