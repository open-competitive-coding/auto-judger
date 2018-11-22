submit:
	bash scripts/submit-solution.sh $(solution-file)
accept:
	bash scripts/accept-solution.sh
clean:
	rm scripts/user-key.txt || true
	rm scripts/user-key-enc.txt || true
	rm scripts/user-key-dec.txt || true

	mv solution/README.md ../ || true
	mv solution/example.c ../ || true
	rm -rf solution/
	mkdir solution
	mv ../README.md solution/ || true
	mv ../example.c solution/ || true
