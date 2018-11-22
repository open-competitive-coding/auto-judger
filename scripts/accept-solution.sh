# This script will be used to accept a solution to a problem.
# NOTE: All commands are run from the root folder of the project.

# Specification of how to submit a solution :
# The solution file will be placed in solution folder.
# The file will be named solution-<PROBLEM-CODE>.ext (eg. solution-11A.c, here 11A is the problem code), where ext can be any of the speicified extensions. See "Supported Extensions" for more details.
# Use the shell script encrypt-solution.sh to encrypt your solution.
# NOTE: After encrypting, it will produce two files solution-enc.ext, user-key-enc.txt.
# Submit the pull request to the repo. NOTE that solution.ext is ignored as a part of .gitignore so that your solution is secured.
# The judge will automatically figure out which language the solution is submitted and run the code against the test cases and submit the verdict.


# How the public and private of the judge has been generated.
# Private Key Generation
# openssl genrsa -out scripts/judge-private-key.txt 2048
# Public Key Generation
# openssl rsa -pubout -in scripts/judge-private-key.txt -out scripts/judge-public-key.txt

# NOTE: All constants are defined in scripts/constants.sh

source scripts/constants.sh

SOLUTION_FILE=$(cat $SOLUTION_FILE_NAME)
ENCRYPTED_SOLUTION_FILE="${SOLUTION_FILE/./-enc.}"
DECRYPTED_SOLUTION_FILE="${SOLUTION_FILE/./-dec.}"

# Lets write the Judge's private key to a file after decoding it from base64.
# And we will do only if we are in circleci.
echo "Hello"
echo $CIRCLECI
echo $CIRCLE_JOB

if [[ -z "$CIRCLECI" ]]; then
    echo "Inside CircleCI YO"
    echo $JUGDE_PRIVATE_KEY > $JUDGE_PRIVATE_KEY_BASE64
    openssl enc -base64 -d -in $JUDGE_PRIVATE_KEY_BASE64 -out $JUDGE_PRIVATE_KEY
fi

# Let's first decrypt the user's private key.
openssl rsautl -decrypt -in $USER_KEY_ENC_FILE_NAME -inkey $JUDGE_PRIVATE_KEY -out $USER_KEY_DEC_FILE_NAME

# Now we will use this key to decrypt the user's solution.
openssl enc -d -aes-256-cbc -in $ENCRYPTED_SOLUTION_FILE -out $DECRYPTED_SOLUTION_FILE -kfile $USER_KEY_DEC_FILE_NAME
