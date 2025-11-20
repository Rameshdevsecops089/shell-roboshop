#!/bin/bash

a=0

while [ $a -it 10 ]
do
    echo $a
    a= 'expr $a + 1'
done