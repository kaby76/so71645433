lexer grammar TestLexer;

@lexer::members {
    private int startIndex = 0;

    private void updateStartIndex()
    {
        startIndex = this.CharIndex;
    }

    private void printNumber()
    {
    TestLexer t = this;
    ICharStream i = t.InputStream as ICharStream;
	    var la = i.LA(1);
        string number = i.GetText(Interval.Of(this.startIndex, this.CharIndex-1));
        System.Console.WriteLine(number);
    }
}

LINE:  {this.Column == 0}? ANSWER
   SPACE {updateStartIndex();}
   ([0-9] {})+ {printNumber();} DOT  (~[0-9])+? NEWLINE;
OTHER:                         . -> channel(HIDDEN);

fragment NUMBER:               ('0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9')+;
fragment ANSWER:               '( ' [A-D] ' )';
fragment SPACE:                ' ';
fragment NEWLINE:              '\n';
fragment DOT:                  '.';
