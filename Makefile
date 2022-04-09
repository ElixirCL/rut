.PHONY: install test coverage lint format static docs archive

i install:
	mix deps.get

t test:
	mix test

c coverage:
	mix test --cover

f format:
	mix format

s static:
	mix credo

l lint:
	make s
	make f
	make t
	make c

d docs:
	mix docs

a archive:
	git archive -o code.zip HEAD
