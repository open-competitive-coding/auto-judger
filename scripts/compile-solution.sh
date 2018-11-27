# This script is used to compile the solution submitted by the if required.
# After this we will try to produce a uniform file which will be used in the further stages.

source scripts/constants.sh

SOLUTION_FILE=$(cat $SOLUTION_FILE_NAME)
DECRYPTED_SOLUTION_FILE="${SOLUTION_FILE/./-dec.}"
LANGUAGE=$(echo $SOLUTION_FILE | awk -F . '{print $NF}') #This is to get the extension from the solution file name
echo $LANGUAGE

# We will create the bin folder where all the executables will be stored.
mkdir -p $BINARY_DIRECTORY

# Basically what we do here is to add support for more and more languages.
if [ $LANGUAGE = $C_LANG ];
then
    echo "Language Identified : C"
    gcc $DECRYPTED_SOLUTION_FILE -o $BINARY_DIRECTORY$EXECUTABLE_FILE
fi
