parser grammar TestParser;

options { tokenVocab=TestLexer; }

root
    : LINE+ EOF
    ;
