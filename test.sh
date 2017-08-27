#!/bin/bash

#simple function that echoes and uses notification for messages.
function message() { 
    echo $@ 
    notify-send "$0" "$@" 
}


message "this is a random test"
