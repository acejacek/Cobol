%: %.cbl
	cobc -free -x $^ -o bin/$@
