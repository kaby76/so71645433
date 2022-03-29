# so71645433

Fix for https://stackoverflow.com/questions/71645433, problem with getCharIndex().

To run, use [trgen](https://github.com/kaby76/Domemtech.Trash/tree/main/trgen) to generate a parser for either CSharp or Java, then "make".
Other targets not supported.

### Grammar without null action in +-operator closure

```
LINE:  {this.getCharPositionInLine() == 0}? ANSWER
   SPACE {updateStartIndex();}
   ([0-9])+ {printNumber();} DOT  (~[0-9])+? NEWLINE;
```

Input:
```
( B ) 12. hahaha
( B ) 123. hahaha
```

Output (wrong):
```
12
12
```

### Grammar with null action in +-operator closure

```
LINE:  {this.getCharPositionInLine() == 0}? ANSWER
   SPACE {updateStartIndex();}
   ([0-9] {})+ {printNumber();} DOT  (~[0-9])+? NEWLINE;
```

Input:
```
( B ) 12. hahaha
( B ) 123. hahaha
```

Output (correct):
```
12
123
```
