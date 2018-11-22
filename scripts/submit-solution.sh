# This script will be used to submit a solution to a problem.

# First we generate a random key say K. We store this in user-key.txt.
# NOTE: This file, user-key.txt is present in .gitignore as this is a secret.
# We use this key to encrypt our solution-<PROBLEM-CODE>.ext file and create a file solution-enc.ext.
# We then encrypt this key using the judge's public key which is stored in judge-public-key.txt and create a file user-key-enc.txt

# NOTE: All constants are defined in scripts/constants.sh

source scripts/constants.sh

# We will store the solution-file name so that it will be easier to derypt it later
echo $1 > $SOLUTION_FILE_NAME

# User Key generation part.
USER_PASSWORD=$(pwgen $USER_PASSWORD_LENGTH 1)

echo $USER_PASSWORD > $USER_KEY_FILE_NAME

ENCRYPTED_SOLUTION_FILE="${1/./-enc.}"

# We will now use this key to encrypt the solution file.
openssl enc -aes-256-cbc -md MD5 -in $1 -out $ENCRYPTED_SOLUTION_FILE -k $USER_PASSWORD

# To decrypt which we will not do here.
# But if someone's curiosity is through the roof, pls uncomment this line and see the magic.
# openssl enc -d -aes-256-cbc -in $1".enc" -out $1".dec" -k $USER_PASSWORD

# We will now encrypt the user-key.txt using the judge's public key and store it in user-key-enc.txt.
# Only the judge will be able to read this key now. Ohh Yeah!

openssl rsautl -encrypt -in $USER_KEY_FILE_NAME -out $USER_KEY_ENC_FILE_NAME -inkey $JUDGE_PUBLIC_KEY -pubin

# To decrypt this key one needs the Judge's private key.
# Hahahaha. Only I know that.
# But assuming that you have the Judge's private key we can decrypt it like this.
# openssl rsautl -decrypt -in $USER_KEY_ENC_FILE_NAME -inkey $JUDGE_PRIVATE_KEY -out $USER_KEY_ENC_FILE_NAME".dec"
