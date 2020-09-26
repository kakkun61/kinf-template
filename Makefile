PWSH = pwsh
SERVE = warp -d

.PHONY: generate
generate: build
	cabal exec -- gen

.PHONY: build
build:
	cabal build .

.PHONY: lint
lint:
	stack exec -- hlint app content

.PHONY: format
format:
	$(PWSH) -Command '& { Get-ChildItem -Path app, content -Include *.hs -Recurse | ForEach-Object { stylish-haskell --inplace $$_ } }'

.PHONY: serve
serve: generate
	$(SERVE) out

.PHONY: clean
clean: clean-content
	cabal clean

.PHONY: clean-content
clean-content:
	$(PWSH) -Command '& { Remove-Item -Path out -Recurse -Force }'

.PHONY: targets
targets:
	$(PWSH) -Command "& { Get-Content .\Makefile | Where-Object { $$_ -like '.PHONY*' } | ForEach-Object { $$_.Substring(8) } }"
