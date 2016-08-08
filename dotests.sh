#!/bin/bash

. ~/.rvm/scripts/rvm
rvm install $(< .ruby-version)
rvm use $(< .ruby-version)

while read BUNDLE_GEMFILE BUNDLER_VERSION
do
    echo
    echo Starting run with $BUNDLE_GEMFILE...
    gem install bundler -v $BUNDLER_VERSION
    export BUNDLE_GEMFILE
    bundle _${BUNDLER_VERSION}_ install && {
        bundle _${BUNDLER_VERSION}_ exec rake test:rspec
        bundle _${BUNDLER_VERSION}_ exec rake test:cucumber
    }
    echo Finished $BUNDLE_GEMFILE.
    rm ${BUNDLE_GEMFILE}.lock
    unset BUNDLE_GEMFILE
done << EOL
gemfiles/vagrant-1.4.0 1.12.5
gemfiles/vagrant-1.4.3 1.12.5
gemfiles/vagrant-1.5.4 1.5.3
gemfiles/vagrant-1.6.5 1.6.9
gemfiles/vagrant-1.7.4 1.10.5
gemfiles/vagrant-1.8.1 1.10.6
gemfiles/vagrant-1.8.5 1.12.5
EOL
