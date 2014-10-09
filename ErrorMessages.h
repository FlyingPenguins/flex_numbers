/*C++ Error Messages*/

main(int argc, int argv){
	int x = 0;
	yylex();
	if (argc == 1){
		cout << "Warning on line " << argv;
		if (argc > x){
			x = argc;
		}
	}
	if (argc == 2){
		cout << "Error on line " << argv;
		/*end compiler here*/
		if (argc > x){
			x = argc;
		}
	}
	if (argc == 3){
		cout << "Fatal on line " << argv;
		if (argc > x){
			x = argc;
		}
		exit();
	}
}