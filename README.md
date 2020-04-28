# COBOL

Small repo with my test programs in Cobol.

Get GnuCOBOL from [SourceForge](https://sourceforge.net/p/open-cobol/wiki/Home/).

All should compile with:
```
$ cobc -free -x -o program_name program_name.cbl
```

Add `-fdebugging-line` flag, if you want to see extra debug messages.

## prime.cbl

I skip *Hello, world!* and did this as my first COBOL program. Blast from past, as this was the first algorythm I programed 30+ years ago, while learning *Action!* on my 8-bit Atari.

Generic implementation of [Sieve of Eratosthenes](https://en.wikipedia.org/wiki/Sieve_of_Eratosthenes). Finds all prime numbers up to given limit. Basic sanity checks on user entry. Arbitrary maximal limit set to 10000.