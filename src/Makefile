all:
	ocamlbuild -use-menhir -menhir "menhir --external-tokens Lexer" Main.native

clean:
	rm *.native
	rm -r _build
