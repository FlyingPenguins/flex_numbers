/* Team: Francis, Brandon, Josh, Bryan, Zoe */
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

/*
 * Simple cases: single/double zero, digit, and more general zero case.  It was
 * better to abstract the single digit cases, because not only did it make the
 * other regular expressions shorter, but it also was a lot easier than trying
 * to cram every possible edge case into a single expression.
 */
ONEZERO         -?00?
ONEDIGIT        -?[0-9]
ZERO            [-?](0{1,2}|(0X|0x))

/* Decimal number case, by Brandon */
DECDIGIT        -?([1-9][0-9]+)

/* Hexadecimal case by Francis */
HEXDIGIT        -?((0X|0x)(0|[1-9A-F]+[0-9A-F]*))

/* Exponents case by Josh */
XDIGIT          -?(([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)

/* The following are by Bryan, Josh helped by testing for edge cases. */
/* Octal case, the single and double zero case is dealt with in ONEZERO case */
OCTDIGIT        -?(0[1-7][0-7]*)
/* Non numbers, similar format to hex. These weren't getting caught anywhere
 * else, so we have to capture them by matching hex + incorrect ending */
NOTHEX          -?{HEXDIGIT}[a-zG-Z]+
/* Numbers and letters that are non numbers */
NUMSLETS        -?([0-9a-zG-WYZ]+)
/* Multiple periods in a non-number. Handles any number of periods, and
 * uses alphanumeric case, for readability, wrapped in a + at the end to allow
 * for any amount of the case getting repeated. */
ALPHANUM        [0-9a-zA-Z]
MULTIDOT        -?({ALPHANUM}*\.{ALPHANUM}*\.{ALPHANUM}*\.*{ALPHANUM}*)+

%%
{ZERO}          {printf("%s number\n", yytext); numbersFound++; }
{ONEZERO}       {printf("%s number\n", yytext); numbersFound++; }
{ONEDIGIT}      {printf("%s number\n", yytext); numbersFound++; }
{OCTDIGIT}      {printf("%s number\n", yytext); numbersFound++; }
{DECDIGIT}      {printf("%s number\n", yytext); numbersFound++; }
{HEXDIGIT}      {printf("%s number\n", yytext); numbersFound++; }
{XDIGIT}        {printf("%s number\n", yytext); numbersFound++; }
{NUMSLETS}      {printf("%s not number\n", yytext); falseNumbers++; }
{MULTIDOT}      {printf("%s not number\n", yytext); falseNumbers++; }
{NOTHEX}        {printf("%s not number\n", yytext); falseNumbers++; }
[ \t]           { }
\n              { }
.               {printf("%s not number\n", yytext); falseNumbers++; }
%%

main(int argc, char **argv)
{
        yylex();
        possibleNumbers = numbersFound + falseNumbers;
        printf("Out of %d possible numbers, ", possibleNumbers );
        printf("there were %d numbers, and ", numbersFound);
        printf("%d not numbers.\n", falseNumbers);
}
