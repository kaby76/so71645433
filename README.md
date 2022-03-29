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

### Analysis

For the input, 4.9.3 runtime creates 2 LexerIndexedCustomAction objects without the '{}' action
at "offset" 6, 7, then flushes action list using FailOrAccept()
(calling the actions containing `updateStartIndex()` and `printNumber()` each twice).

With the '{}' action, it creates 7 LexerIndexedCustomAction objects,
at "offset" 6, 7, 7,
flushes action list using FailOrAccept()
(calling the actions containing `updateStartIndex()`, empty action, and `printNumber()`),
"offset" 7, 8, 9, 10, 10,
 flushes action list using FailOrAccept()
(calling the actions containing `updateStartIndex()`, empty action 4 times, and `printNumber()`).

[FailOrAccept()](https://github.com/antlr/antlr4/blob/97c793e446ba70e4e63f84e6c2bffd5fffd961a5/runtime/CSharp/src/Atn/LexerATNSimulator.cs#L286)
unwinds the list of actions to execute. That list contains the number of actions to execute.
In the first case, there are two actions.

In the '{}' action grammar, FailOrAccept() is called twice.
The first time, there are three actions.
The second time, there are six actions.

