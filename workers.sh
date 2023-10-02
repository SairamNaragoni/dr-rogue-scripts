#!/bin/bash
#create multiple workers env with 4 in offset 0 and 5 in provided offset

NUM_WORKERS=$1
OFFSET=$2

cp worker-2.env

sed -i~ '/^TEST_VAR=/s/=.*/="UpdateValue"/' file.env

sed -i~ '/^DR_WORLD_NAME=/s/=.*/=reinvent_base/' worker-2.env 