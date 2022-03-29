lexer grammar TestLexer;

@lexer::members {
    private int startIndex = 0;

    private void updateStartIndex() {
        startIndex = getCharIndex();
    }

    private void printNumber() {
        String number = _input.getText(Interval.of(startIndex, getCharIndex() - 1));
        System.out.println(number);
    }
}

LINE:  {this.getCharPositionInLine() == 0}? ANSWER
   SPACE {updateStartIndex();}
   ([0-9] {})+ {printNumber();} DOT  (~[0-9])+? NEWLINE;
OTHER:                         . -> channel(HIDDEN);

fragment NUMBER:               ('0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9')+;
fragment ANSWER:               '( ' [A-D] ' )';
fragment SPACE:                ' ';
fragment NEWLINE:              '\n';
fragment DOT:                  '.';
