#!/bin/bash

dtrace \
	-xstackframes=100 \
	-n 'profile-997{@[stack()]=count()}' \
	-c 'sleep 30' | \
	./stackcollapse.pl | \
	./flamegraph.pl \
	>$$.svg
echo created $$.svg
