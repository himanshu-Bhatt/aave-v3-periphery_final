# Aave - Reward Distributtor Formal Verification Contest
- Total Prize Pool: $40,000 USDC
  - HM awards: $22,000 USDC
  - Injected Bug awards: $14,000 USDC
  - Participation: $4,000 USDC
- Join [Certora discord](https://discord.com/channels/795999272293236746/967783163386536007) to get support and updates 
- [Register](https://docs.google.com/forms/d/e/1FAIpQLSc_cFHv0BP9B3B5Ri1cBqho-6y4bsPhMpAAypUZazsHINgbfQ/viewform) through Certora to gain access to the prover
  - Most information for installing and using the Certora Prover are available [here](https://docs.certora.com/en/latest/)
  - Additional resources to get familiar with the Certora Prover will be emailed to registrants along with their Certora key. 
- Starts July 19, 2023 20:00 UTC
- Ends August 2, 2023 20:00 UTC

---

# Notice

Please note that this is a formal verification contest; the goal of the contest is not just finding bugs, we are looking for implementations of properties in CVL (Certora Verification Language) which can either uncover bugs or prove properties of the contract always hold. To reflect that, we created an incentive model that awards real bug findings as well as verification of protocol properties in a relatively equal manner. Please read this document in its entirety to ensure you fully understand the contest.

---

# Overview

An overview of the rewards distributor and it's place in the Aave ecosystem can be found in:
1. [Docs on how to incentivize tokens on Aave](https://docs.aave.com/developers/guides/governance-guide/rewards).
2. [The contract's documentation](https://docs.aave.com/developers/periphery-contracts/rewardscontroller).
3. [Readme of the repository](./info.md)

This challenge is about using the Certora prover to formally verify properties in the Solidity smart contract `contracts/rewards/RewardsController.sol`. 

We will introduce several bugs in the smart contract, some of which are publicly available as patch files in `certora/tests/certora/`. The rest of the bugs will be made public at the end of the contest and will be used to evaluate the properties proven. You can find more information on the incentive structure and participation instructions further down in this doc.

# Scope

| Contract | SLOC | Purpose | Libraries used |  
| ----------- | ----------- | ----------- | ----------- |
|[contracts/rewards/RewardsController.sol](https://github.com/Certora/aave-v3-periphery_contest/blob/master/contracts/rewards/RewardsController.sol)|[](#nowhere "(nSLOC:458, Lines:917)")|-|

# Additional Context

## Installation

This section explains 2 methods to install required dependencies to execute Certora on the specification `certora/specs/*.spec`. The first method uses the docker file
located in the `docker` directory. The other method explains which tools need to be installed.

### Installing Manually

Installation instructions can be found [here](https://docs.certora.com/en/latest/docs/user-guide/getting-started/install.html?highlight=install). Briefly, you must install
* Java Development Kit version >= 11.
* Solidity version 0.8.10 (exactly this version).
* One can install Certora with the Python package manager Pip3,
  ```
  pip3 install certora-cli
  ```
* Upon cloning the repository, it is best to clone the repository with the option `--recurse-submodules` to ensure you download the necessary submodules that the contract uses.

### Installing With Docker

There is a docker file in the `docker` folder, with instructions to create an environment with
dependencies required for executing Certora. The container will be created with a user with
username 'docker' and password 'docker'. On a Unix system with an sh shell, the docker container
can be built with the `docker/build.sh` script. For example
```
docker/build.sh auto auto
```
builds the container with the docker user having the same user id and group id as the user executing
the `build.sh` script. The user id and group id are inferred using the `id` command. This is the
typical case.

If one wants to specify the user id and/or group id manually, then that is also possible. The first
argument to the `build.sh` script is the user id and the second argument is the group id,
```
docker/build.sh 1234 4321
```

When the container is built, then it can be started with the `docker/run.sh` script. For example
```
docker/run.sh "`realpath .`"
```
where the argument to `run.sh` is the absolute path to this repository (static-a-token-v3).
The repository will then be volume mapped for use inside the running docker container.

IMPORTANT: The docker container is automatically removed after exiting, so that all changes to the
container will be deleted. But since the repository static-a-token-v3 is volume mapped inside
the container, changes to the repository will be persistent, even after the docker container has
exited.

## Documentation on Certora

* The Certora documentation is located at https://docs.certora.com/en/latest/index.html
* There is a tutorial on Certora here https://github.com/Certora/Tutorials/blob/master/README.md

## Documentation on Aave protocol (useful background knowledge).

To gain some background knowledge on the `RewardsController.sol` smart contract, it may be useful to take a look at the following documentation:
* [AToken](https://docs.aave.com/developers/tokens/atoken#atoken)

---
# Formal Verification Contest Incentive Model
## Key Takeaways
* The objective is to prove strong properties. Strength will be checked by testing the proven properties against 15 bugs, 3 of which are public from the start. Properties that catch real bugs are considered strong already.
* The total reward is split into three categories: participation, real bugs, and injected bugs
* Participation rewards are given to all security contributors that have a spec which catches 2 out of 3 publicly available injected bugs.
* Discrete injected bugs’ and real bugs’ awards are calculated similarly, according to the following formulae:
```
Med Risk Shares: 3 * (0.9 ^ (findingCount - 1)) / findingCount
```
```
High Risk Shares: 10 * (0.9 ^ (findingCount - 1)) / findingCount
```
* Real bugs will require more details such as impact and an example exploit scenario. 

## Incentives
A formal verification contest will still have a predefined total bounty which will be awarded in its entirety to security contributors. The specific distribution of rewards will be based on contributors’ performance. The rewards will be split into 3 categories and each category will have its own point system. The categories will be real bugs, injected bugs, and participation. 55% of the total bounty will be awarded to specifications catching real bugs, 35% to those catching the injected bugs and 10% for participation. In the case that no real bugs are found, participation pool will be increased to 22% and injected bugs pool will be increased to 78%.

The rewards for participating will be split equally among all eligible participants. To be eligible, participants must submit a specification which passes on the original code and fails on the publicly available injected bugs. The bugs will be provided by Certora and will be similar to the discrete injected bugs but will be part of the repo at the beginning of the contest.

The rewards for real bugs and injected bugs will be distributed very similarly, but since they are separate categories, the points for each category will be distinct. In both cases, contributors will receive points based on the bugs they discover. Each bug will start at a fixed total point value which will be split equally among all contributors if multiple contributors discover the same bug. The total points for a given bug will be reduced exponentially as the number of discoverers increases**. 

For real bugs, high and medium severity bugs will have a total value of 4 and 1 points respectively. Low severity bugs will not be accepted. Severity will be determined by the judges based on severity and likelihood. The contest being judged by Certora. To receive rewards for real bugs, submissions must describe the bug and include a rule that detects the bug.

For discrete injected bugs and real bugs the total number of points a bug is worth decreases as the number of discoverers increases. The value deteriorates based on the equation X * 0.9 ^ (n-1) where X is the initial value of the bug and n is the number of discoverers. This is put in place to prevent sybil attacks.

---
# Working Instructions for Formal Verification Contests
## Overview

* Create a private fork of the [public repository](https://github.com/Certora/aave-v3-periphery_contest) and give access to judges.
* Implement properties in the `certora` branch.
* Set up all your conf files in the `certora/confs` directory to check the specification against the code.
* Submit your work by creating a pull request from the `certora` branch to the `main` branch.

## Setup

To ensure other participants will not copy your properties, create a private fork of [this repository](https://github.com/Certora/aave-v3-periphery_contest). 

### How to create a private fork
Creating a private fork is fairly easy. To do so simply:

1. Go to your GitHub repository page and create an empty new private repository.

2. In your empty repository scroll all the way down and look for the "import code" button.

3. In the central textbox paste [certora's public repository url](https://github.com/Certora/aave-v3-periphery_contest) and press the "Begin import" button.

And Voilà, you have a private fork!
Now you can clone the repository to your local machine so that you'll be able to work:

1. In your repository, press the big green button saying "Code" and copy the url displayed there.

2. In your terminal, clone the repository by executing:
```
git clone <url> --recurse-submodules
```
* `--recurse-submodules` flag makes sure to initialize and clone the referenced submodules in the repository. This is not always needed, but it doesn't do any harm if no submodules exist.

You now have the git repository locally on your machine :). As a last step, we will add the parent public repository as a remote on our local repository, just in case we will need to sync something in the future:

1. In the repository add a remote by executing:
```
git remote add certora-repo <url>
```
where `<url>` is the same url retrieved from the big green "code" button on the parent public repository.

2. Check that the remote was added by executing:
```
git remote -v 
```

3. Whenever you're required to sync your repository with changes introduced by Certora, you simply need to:

    3.1. Fetch the latest information from the remote
    ```
    git fetch `certora-repo`
    ```

    3.2. Checkout to the desired branch
    ```
    git checkout <branch>
    ```

    3.3. Pull the modified code from the origin (`certora-repo`) branch to the current branch you're standing on in your local machine by executing
    ```
    git pull certora-repo <branch> --recurse-submodules
    ```

    This last action should pull the code from the `certora-repo` remote and embed it into the branch you checked out to. You potentially need to sort out conflicts, but in general you code is now synced and ready to push to your private remote whenever you need to.

You’ll need to sync 2 branches on your fork:
* `certora` - your working branch.
* `main` - a reference branch that should not be touched unless instructed otherwise.

Make sure to grant read access to the judges `mailalexjoseph`, `tomerganor`, `nd-certora`, `gadi03`, `shoham-certora`, `nisnislevi`, `MichaelMorami` on GitHub.

Add a repository secret to your repo named `CERTORAKEY` with the key that will be emailed to you once you sign up through Certora (link is in the contest details above).

The forked repository will contain a `certora` directory that consists of 4 sub-directories - `harnesses`, `conf`, `tests` and `specs`. These should contain the entire preliminary setup to allow you to start writing rules. Each sub-directory contains a different component of the verification project and may contain additional sub-directories to maintain organization. Try to keep a similar structure when adding new files.

### Setting Up The Project
In order to compile the contracts you'll need to install some packages using npm. Follow [info.md](./info.md)'s "Getting started" section for instructions. Please note that the contracts require solc8.10. if you use solc-select, you don't use solc-select, you'll have to add `"solc": "solc8.10"` in all your conf files

## Participation 

In the certora/spec directory, you will find `.spec` files named `<name_of_contract>_verified.spec`. In these specs, gather all the rules and invariants that you were able to verify. Some functions, definitions, and properties have been setup up for you to serve as an example. Before submitting these specs, make sure to check the following things:

* Add the `--rule_sanity` flag to your conf files and check the entire spec to make sure that all rules are reachable at time of submission. Rules that are not reachable will not be counted towards participation as they will not catch any bugs.

* Document each rule/invariant with a comment above that describes what the rule does in simple English. Any rule/invariant that isn’t documented will not be counted.

* It is recommended to inject a bug for each rule you write. This will ensure the rule is doing what you think it should be doing. To get more info on how to save injected bugs easily and undo changes, read the `README` in `certora/tests` and run `make help` from the certora directory.

**Do not leave failing rules or rules that are unreachable in the specs.**

Rules that find issues, should be moved to the files `<name_of_contract>_issues.spec`. These files should contain only rules that fail and uncover real issues in the original code. For each rule that uncovers an issue/bug in the code document exactly as instructed for passing rules. In addition, paste have 2 links:

1. A link to a counter example that disproof the property.

2. A link to a GitHub issue that elaborate on the bug/issue.

Instructions regarding the ideal way to "pitch" your bug report can be found below in the `Reporting Real Bugs` section.

**Do not leave unfinished rules/invariants in any of the spec files.**


## Testing

In the certora/conf directory, you will find conf file(s) that contains examples that can be used to run of your submitted spec files. You may need to configure these differently as you progress through the project. Many of the options available are documented [here](https://docs.certora.com/en/latest/docs/prover/cli/options.html?highlight=script). It is recommended to test your spec against the publicly available injected bugs, as well as bugs you injected yourself, to ensure your rules are working properly. You can do so by using the `verifyAllInjected.sh` script. This script will inject either the bugs injected by you or by certora one by one and run your spec against them.

* Note that you need to pass an arg to the script, stating which of the 2 directories under `test` you want to run you specs against.

## Submission

At the end of the contest, open a pull request within your repository from the `certora` branch to the `main` branch. Upon opening the PR, the CI will be triggered, running your spec against the publicly available injected bugs. **Make sure to add a `CERTORAKEY` as a repository action secret.** Also ensure that none of your run scripts have a `--send_only` flag.

A short time after the deadline, Certora will update the `certora` branch in the public repository with the additional non-released bugs. You will need to pull these changes to your repository. The CI will again be triggered and the result of the CI for these new jobs will be evaluated by the judges. If any additional changes need to be made once the discrete injected bugs are made public, please contact us first for permission. **Any changes made after the update without contacting Certora will result in disqualification.**

## Reporting Real Bugs
After finding a potential bug/unintended behaviour of the contract with the Certora Prover, open a GitHub issue on your repository that explains the potential problem. Follow the guidelines below when creating a GitHub issue:

* Title - Usually short, informative sentence that describe the worst case scenario that the bug allow, e.g. "Potential significant asset loss due to overflow in deposit function".

* Summary - Short description of the problem in 1-3 sentences. Usually explains the problem without going too deep into details, but gives a little more information than the title. Can contain the title.

* A reference to the line(s) of code that causes this issue.

* Property violated - the name of the property that caught the bug and a **link** to a report with a violation demonstrating the violation.
  * Make sure to document the property that caught the issue according to the instructions specified in Participation

* Elaborative explanation of the bug and an attack case example
  * Make sure to explain what’s the expected behaviour of the system.
  * What’s the actual behaviour of the system?
  * What is the potential loss that can occur due to the bug? e.g. the entire liquidity can be removed from existence, an amount depends on initial capital can be stolen, rounding of 1 unit,
  * Who loses (protocol or users). 
  * Try to plug in reasonable numbers to understand the damage that can be inflicted. Is the loss of funds bounded? 

It is best to try and escalate the problem and try to think about the worst-case scenario possible using the breach.

Following these guidelines will help you write reports with greater clarity, which will help us understand the problem quicker, reduce the chance of overlooking real findings and decrease the evaluation time at the end of each contest.

For a period of time after the deadline, the judges will examine the bug and might contact you for clarifications. The goal of the meeting, in case it’s scheduled, is for the judges to get extra information and clarifications on the potential bug and the possible attack vector. To prepare for the meeting, please reread your report, refresh your memory on the issue, and consider planning a concrete example of an attack.
