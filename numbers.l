/* Team: Francis, Brandon, Josh, Bryan */
/* (not) just like Unix wc */
/* code from first example here: */
/*        ftp://ftp.iecc.com/pub/file/flexbison.zip */

%option noyywrap


%{
int posNums = 0;
int nums = 0;
int nonNums = 0;
%}

%%
-?00/[ \s\n] {posNums++; nums++; printf("(%s) Octal number rule 1, for -?00\n", yytext); }
-?0[1-7][0-7]+/[ \s\n] {posNums++; nums++; printf("(%s) Octal number rule 2, for -?0[1-7][0-7]...\n", yytext); }
-?[0-9]*[a-zA-Z]+[a-zA-Z0-9]+/[ \s\n] {posNums++; nonNums++; printf("(%s) not a number! matching 06a...\n", yytext); }
[-]?[0][0-9]+/[ \s\n]	{posNums++; nonNums++; printf("(%s) not a number\n", yytext);}

[-]?[^a-zA-Z0-9]+(0X|0x)[a-fA-F0-9]+/[\s\n] {posNums++; nums++; printf("(%s) number through hex rule 1\n", yytext);}

[-]?([1-9][0-9]*|[0][^0-9]*)/[ \s\n] {posNums++; nums++; printf("(%s) number\n", yytext);}
-?(([0-9]+)|([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?)/[ \s\n] {printf("%s NUMBER \n", yytext); }
[ \t]   { }
\n      { }
.       { printf("%s didn't match any rule, just .  \n", yytext); }


%%

int main(int argc, char **argv)
{
yylex();
printf("Out of %d possible numbers, there were %d numbers, and %d not numbers.\n", posNums, nums, nonNums);
}
