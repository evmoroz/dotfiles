#!/usr/bin/env bash
if [ -n "$AWS_DEFAULT_PROFILE" ]; then
    echo -n "$AWS_DEFAULT_PROFILE";
fi
if [ -n "$AWS_DEFAULT_REGION" ]; then
    echo -n "/$AWS_DEFAULT_REGION";
fi
if [ -n "$ENVIRONMENT" ]; then
    echo -n "/$ENVIRONMENT";
fi
