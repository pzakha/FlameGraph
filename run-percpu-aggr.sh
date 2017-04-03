#!/bin/bash

dtrace \
	-xstackframes=100 \
	-qn 'profile-997{@[stack(),cpu]=count()} END {printa("%kcpu_%d\n%@d\n",@)}' \
	-c 'sleep 30' | \
	./stackcollapse.pl | \
	./flamegraph.pl \
	>$$.svg
echo created $$.svg
