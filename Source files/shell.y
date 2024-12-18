%token	<string_val> WORD

%token 	NOTOKEN GREAT NEWLINE APPEND READ PIPE BACKGROUND EXIT ERR

%union	{
		char   *string_val;
	}

%{
extern "C" 
{
	int yylex();
	void yyerror (char const *s);
}
#define yylex yylex
#include <stdio.h>
#include "command.h"
%}

%%

goal:	
	commands
	;

commands: 
	command
	| commands command 
	;

command: simple_command
        ;

simple_command:
	EXIT NEWLINE{
		printf("\n\t\t\t Good Bye! :)\n\n");
		exit(0);
	}
	| command_and_args iomodifier_opt BACKGROUND NEWLINE {
		printf("   Yacc: insert background = TRUE\n");
	 	Command::_currentCommand._background=1;
		printf("   Yacc: Execute command\n");
		Command::_currentCommand.execute();
	}
	| command_and_args iomodifier_opt NEWLINE {
		printf("   Yacc: Execute command\n");
		Command::_currentCommand.execute();
	}
	| command_and_args iomodifier_opt PIPE commands {
		printf("   Yacc: Execute command\n");
		Command::_currentCommand.execute();
	}
	| NEWLINE 
	| error NEWLINE { yyerrok; }
	;

command_and_args:
	command_word arg_list {
		Command::_currentCommand.
			insertSimpleCommand( Command::_currentSimpleCommand );
	}
	;

arg_list:
	arg_list argument
	| /* can be empty */
	;

argument:
	WORD {
               printf("   Yacc: insert argument \"%s\"\n", $1);

	       Command::_currentSimpleCommand->insertArgument( $1 );\
	}
	;

command_word:
	WORD {
               printf("   Yacc: insert command \"%s\"\n", $1);
	       
	       Command::_currentSimpleCommand = new SimpleCommand();
	       Command::_currentSimpleCommand->insertArgument( $1 );
	}
	;

iomodifier_opt:
	GREAT WORD {
		printf("   Yacc: insert output \"%s\"\n", $2);
		Command::_currentCommand._outFile = $2;
	}
	| APPEND WORD {
		printf("   Yacc: insert append output \"%s\"\n", $2);
		Command::_currentCommand._outFile = $2;
		Command::_currentCommand._append = 1;
	}
	| READ WORD {
		printf("   Yacc: insert input \"%s\"\n", $2);
		Command::_currentCommand._inputFile = $2;
	}
	| READ WORD GREAT WORD {
		printf("   Yacc: insert output \"%s\"\n", $4);
		Command::_currentCommand._outFile = $4;
		printf("   Yacc: insert input \"%s\"\n", $2);
		Command::_currentCommand._inputFile = $2;
	}
	| READ WORD APPEND WORD {
		printf("   Yacc: insert append output \"%s\"\n", $4);
		Command::_currentCommand._outFile = $4;
		printf("   Yacc: insert input \"%s\"\n", $2);
		Command::_currentCommand._inputFile = $2;
		Command::_currentCommand._append = 1;
	}
	| ERR WORD {
		printf("   Yacc: insert error \"%s\"\n", $2);
		Command::_currentCommand._errFile = $2;
	}
	|
	;

%%

void
yyerror(const char * s)
{
	fprintf(stderr,"%s", s);
}

#if 0
main()
{
	yyparse();
}
#endif