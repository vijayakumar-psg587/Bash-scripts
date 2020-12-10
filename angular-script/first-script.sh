#! /bin/bash

# The intial first step we wanted to do is run npm install
npm install

# Incorporate linting script if needed


# Error exit function
common_error_fn()
{
    echo "${1:-"Unknown Error"}"
    exit 1
}

build_fn()
{
    echo "ng build "$1""
    exit 0
}

# These two varaibles come from the environments that will be loaded when npm commands are started

ENV_DEV=${NODE_ENV_DEV:=development}
ENV_TEST=${NODE_ENV_TEST:=test}
ENV_PROD=${NODE_ENV_PROD:=production}
echo "My name is ${NAME}"
echo $ENV_DEV
echo $NODE_ENV
if [ "$NODE_ENV" = "$NODE_ENV_DEV" ];
then
    echo "### This is a develop/local environment. Hence config.json remains the same "
    # Use the corresponding values from local.json to put it in sed - but have to replace for all values
    # sed -i 's/http:\/\//<Actual values>/g' ./config.json
    # An easier appraoch
    cat ./config-local.json > ./config.json
    build_fn
elif [ "$NODE_ENV" = "$NODE_ENV_TEST" ];
then
    echo "### This is a test/QA environment - updating config.json with respective values"
    cat ./config-test.json > ./config.json
    build_fn
elif [ "$NODE_ENV" = "$NODE_ENV_PROD" ];
then
    echo "### This is a Prod environment - updating config.json with respective values"
    
    cat ./config-prod.json > ./config.json
    build_fn --prod
else
    common_error_fn "No environment is provided ! Please provdde an environment or check the npm script executed"
fi

# Now run npm build
# Again this should be a command package.json

