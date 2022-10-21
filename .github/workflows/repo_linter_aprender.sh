#!/bin/bash

# Encontre o repositório no git diff e configure-o para uma variável env.
REPO_TO_LINT=$(
	git diff origin/main -- readme.md |
	# Procure por mudanças (indicadas por linhas começando com +).
	grep ^+ |
	# Obtém a linha que inclui o readme.
	grep -Eo 'https.*#readme' |
	# Obtém apenas o URL.
	sed 's/#readme//')

# Se não for encontrado nenhum repositório, saia silenciosamente.
if [ -z "$REPO_TO_LINT" ]; then
	echo "Nenhum novo link encontrado no formato: https://....#readme"
else
	echo "Clonando $REPO_TO_LINT"
	mkdir cloned
	cd cloned
	git clone "$REPO_TO_LINT" .
	npx aprender-lint
fi
