/* Team: Francis, Brandon, Josh, Bryan */
/*
 * (not) just like Unix wc
 * code from first example here:
 * ftp://ftp.iecc.com/pub/file/flexbison.zip
*/

%option noyywrap

%{
int possibleNumbers = 0;
int numbersFound = 0;
int falseNumbers = 0;
%}

ALPHANUM        [0-9a-zA-Z]
ONEZERO         -?00?
ONEDIGIT        -?[0-9]
ZERO            [-?](0{1,2}|(0X|0x))0
OCTDIGIT        -?(0[1-7][0-7]*)
HEXDIGIT        -?((0X|0x)(0|[1-9A-F]+[0-9A-F]*))
NOTHEX          -?{HEXDIGIT}[a-zG-Z]+
DECDIGIT        -?([1-9][0-9]+)
XDIGIT          -?(([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)
NUMSLETS        -?([0-9a-zG-WYZ]+)
MULTIDOT        -?{ALPHANUM}*\.{ALPHANUM}*\.{ALPHANUM}*

%%
{ZERO}          {printf("%s NUMBER ZERO\n", yytext); numbersFound++; }
{ONEZERO}       {printf("%s NUMBER ONEZERO\n", yytext); numbersFound++; }
{ONEDIGIT}      {printf("%s NUMBER ONEDIGIT\n", yytext); numbersFound++; }
{OCTDIGIT}      {printf("%s NUMBER OCTDIGIT\n", yytext); numbersFound++; }
{DECDIGIT}      {printf("%s NUMBER DECDIGIT\n", yytext); numbersFound++; }
{HEXDIGIT}      {printf("%s NUMBER HEXDIGIT\n", yytext); numbersFound++; }
{XDIGIT}        {printf("%s NUMBER XDIGIT\n", yytext); numbersFound++; }
{NUMSLETS}      {printf("%s NOT NUM (NUMSLETS)\n", yytext); falseNumbers++; }
{MULTIDOT}      {printf("%s NOT NUM (MULTIDOT)\n", yytext); falseNumbers++; }
{NOTHEX}        {printf("%s NOT NUM (NOTHEX)\n", yytext); falseNumbers++; }
[ \t]           { }
\n              { }
.               {printf("%s NOT NUMBER\n", yytext); falseNumbers++; }
%%

main(int argc, char **argv)
{
        yylex();
        possibleNumbers = numbersFound + falseNumbers;
        printf("The total possible numbers was %d\n", possibleNumbers );
        printf("The total number of actual numbers was %d\n", numbersFound);
        printf("The number of rejected numbers was %d\n", falseNumbers);
}
