# Hand Game - Group of Cards Validator
> Auther: Abdalrahamn M. Srour <eng.abdsrour@gmail.com> <3bd.srour@gmail.com>

This is a Ruby based command line application that validate a group of cards if they are a valid Hand Game group or not!

To run unit tests:
```
./test.sh
```

To run application:
```
./run.sh "<cards list>"
```

Example:
```
./run.sh "4h, 4c, 4s, 4d"
./run.sh "Qh, Kh, 1j"
```

## Structure

There is two folders in the repository, "src" and "test".
"src" folder has the source code for the validator in "HandGroupValidator.rb" and the helper classes and module "Cards.rb". Along side with "main.rb"

- "HandGroupValidator.rb" has one exported method `handValidateCardGroup` which accept an Array of strings, and do validation, it will return true if the group is valid and false if not or error occured while parsing the array!

- "Cards.rb" has classes and modules that are being used by "HandGroupValidator.rb" and user do not have to use it or import it!

- "main.rb" this is a command-line tool to test "HandGroupValidator.rb", it accept the array as command-line argument and pass it to the method `handValidateCardGroup`, then prints the result!

"test" folder has 3 files "Test.rb" which has the implementation of `SR_Test` class that is used for unit testing
also:

- "test_Cards.rb" has unit tests for "Cards.rb" classes and methods!

- "test_HandGroupValidator.rb" has unit tests for `handValidateCardGroup`.

tests can be run using "test.sh" script in root folder!
