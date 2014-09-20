/* Team: Francis, Brandon, Josh, Bryan */
/* (not) just like Unix wc */
/* code from first example here: */
/*        ftp://ftp.iecc.com/pub/file/flexbison.zip */

%option noyywrap

%{
int possibleNumbers = 0;
int numbersFound = 0;
int falseNumbers = 0;
%}

ZERO            [-?]0{1,2}|(0X|0x)0
OCTDIGIT        -?(0[1-7][0-7]*)
HEXDIGIT        -?((0X|0x)[1-9A-F]+[0-9A-F]*)
DECDIGIT        -?([1-9][0-9]+)
XDIGIT          -?(([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)

%%
{ZERO}          {printf("%s NUMBER ZERO\n", yytext); numbersFound++; }
{OCTDIGIT}      {printf("%s NUMBER OCTDIGIT\n", yytext); numbersFound++; }
{DECDIGIT}      {printf("%s NUMBER DECDIGIT\n", yytext); numbersFound++; }
{HEXDIGIT}      {printf("%s NUMBER HEXDIGIT\n", yytext); numbersFound++; }
{XDIGIT}        {printf("%s NUMBER XDIGIT\n", yytext); numbersFound++; }
.*              {printf("%s NOT NUMBER\n", yytext); falseNumbers++; }
%%

main(int argc, char **argv)
{
        yylex();
        possibleNumbers = numbersFound + falseNumbers;
        printf("The total possible numbers was %d\n", possibleNumbers );
        printf("The total number of actual numbers was %d\n", numbersFound);
        printf("The number of rejected numbers was %d\n", falseNumbers);
}
