#!/bin/bash

cd $HOME
./update_images.sh
dr-update && dr-start-training
