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
[0-9]* {posNums++; nums++; printf("%s number\n", yytext);}
.* {posNums++;}

%%

int main(int argc, char **argv)
{
yylex();
printf("Out of %d possible numbers, there were %d numbers, and %d not numbers.\n", posNums, nums, nonNums);
}
