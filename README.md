# auto-judger [![CircleCI](https://circleci.com/gh/open-competitive-coding/auto-judger.svg?style=svg)](https://circleci.com/gh/open-competitive-coding/auto-judger)
This is the auto-judge module of the [Open Competitive Coding] project. To solve any question defined in the [problem-set], one has to submit a pull request to this repository.

## Solving a question
Choose any question from the [problem-set]. In the [solution/](./solution) folder create a file by the name of the problem. For e.g. if the problem name is `117-A`, then create `117-A.c` if you are solving in [C] or `117-A.go` if you are solving in [golang]. See [supported programming languages](languages-supported/README.md) to see what all languages are supported.

Say you are have solved the question `example-A` by writing [example.c](./solution/example-A.c), then execute the following command :
```bash
make submit solution-file=solution/example-A.c
```

Use `make clean` to clean up all the mess created.

Commit all the files and raise a pull request against the `master` branch.

That's it! Once you see a ✅  against your pull request, that means that your solution is accepted.


## How does it work ?
[auto-judger] is all about open-source, free integrations, minimalism along with state of the art security principles.

### How is my code executed ?
The code that you submit is compiled (if required) and executed according to the language specified using specialized scripts that understand how to compile and run the code. The way that [auto-judger] compiles, executes and evaluates your solution is also open-source and can be seen in [supported programming languages](languages-supported/README.md).

### Where is my code executed ?
Your code is built and executed using [CircleCI] which is a free service for all open source repositories.

### If everything is open-source, how is my code secure ?
Security is a very critical part of [auto-judger]. How do we secure your code :
* We generate a random key `K1` and use it to encrypt your solution.
* We then use the public-key of [auto-judger] to encrypt this key to `K2`
    * Since we use asymmetric cryptography, only [auto-judger] (who has the corresponding) private key will be able to decrypt this key.
* After decrypting the key `K2` we get `K1` which was originally used for encrypting the solution.

**The only piece of the puzzle which is unknown to the world is the private key of the judge. All the other information is open-source and accessible to all. Still the system is as secure as any other online judge without compromising on any of the features.**

Where the code for all this magic :
* [scripts/submit-solution.sh](./scripts/submit-solution.sh) is used to submit your solution.
* [scripts/accept-solution.sh](./scripts/accept-solution.sh) is used to decrypt you solution.

## Current State
This project is at its very early stages and requires a lot of contribution from the open-source community. So feel free to send a Pull Request to enable any of the features.
- [x] Secure way of transmitting code.
- [ ] Support for major programming languages like C, C++, Java and Python.
- [ ] Integration with problem set.
- [ ] Mapping features like timeout and test-case generators to the module.
- [ ] Create a react-page to show leaderboard globally and for the contest etc.
- [ ] Provide feature to create a context. How do we end judging for a contest ? What does the data-schema look like ?

[Open Competitive Coding]: https://github.com/open-competitive-coding
[problem-set]: https://github.com/open-competitive-coding/problem-set
[C]: https://en.wikipedia.org/wiki/C_(programming_language)
[golang]: https://golang.org/
[auto-judger]: https://github.com/open-competitive-coding/auto-judger
[CircleCI]: https://circleci.com/
