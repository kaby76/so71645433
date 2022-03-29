# so71645433

Fix for https://stackoverflow.com/questions/71645433, problem with getCharIndex().

To run, use [trgen](https://github.com/kaby76/Domemtech.Trash/tree/main/trgen) to generate a parser for either CSharp or Java, then "make".
Other targets not supported.

Why does this work?

```
LINE:  {this.getCharPositionInLine() == 0}? ANSWER
   SPACE {updateStartIndex();}
   ([0-9] {})+ {printNumber();} DOT  (~[0-9])+? NEWLINE;
```

But, this does not.

```
LINE:  {this.getCharPositionInLine() == 0}? ANSWER
   SPACE {updateStartIndex();}
   ([0-9])+ {printNumber();} DOT  (~[0-9])+? NEWLINE;
```

for input:
```
( A ) 1. haha
( B ) 1234. hahaha
```

Expected output:

```
1
1234
```

Actual output:

```
1
1
```

### Analysis

In the case without the empty action,
the predicate gets information from the first token of that type found,
not the information per specific token.
