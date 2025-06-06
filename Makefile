.PHONY: help install dev test lint format clean docker-up docker-down migrate seed

# Variáveis
PYTHON = python3
PIP = pip3
DOCKER_COMPOSE = docker-compose

# Help
help: ## Mostra esta mensagem de ajuda
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Instalação e Setup
install: ## Instala dependências do projeto
	$(PIP) install -r requirements.txt
	$(PIP) install -r requirements-dev.txt

setup: ## Setup inicial do projeto
	$(PYTHON) -m venv venv
	source venv/bin/activate && make install
	cp .env.example .env
	@echo "Configure o arquivo .env com suas credenciais"

# Desenvolvimento
dev: ## Inicia ambiente de desenvolvimento
	$(DOCKER_COMPOSE) up -d postgres redis
	uvicorn src.main:app --reload --host 0.0.0.0 --port 8000

dev-full: ## Inicia ambiente completo de desenvolvimento
	$(DOCKER_COMPOSE) up -d

# Testes
test: ## Executa testes
	pytest tests/ -v --cov=src --cov-report=html

test-unit: ## Executa apenas testes unitários
	pytest tests/unit/ -v

test-integration: ## Executa apenas testes de integração
	pytest tests/integration/ -v

# Qualidade de código
lint: ## Executa linting
	flake8 src/ tests/
	mypy src/

format: ## Formata código
	black src/ tests/
	isort src/ tests/

check: ## Verifica qualidade do código
	make format
	make lint
	make test

# Docker
docker-up: ## Sobe containers Docker
	$(DOCKER_COMPOSE) up -d

docker-down: ## Para containers Docker
	$(DOCKER_COMPOSE) down

docker-logs: ## Mostra logs dos containers
	$(DOCKER_COMPOSE) logs -f

docker-build: ## Rebuilda containers Docker
	$(DOCKER_COMPOSE) build

# Database
migrate: ## Executa migrações
	$(PYTHON) scripts/migration/run_migrations.py

migrate-create: ## Cria nova migração
	@read -p "Nome da migração: " name; \
	$(PYTHON) scripts/migration/create_migration.py "$$name"

seed: ## Popula banco com dados de teste
	$(PYTHON) scripts/setup/seed_data.py

# Supabase
supabase-status: ## Verifica status do Supabase
	$(PYTHON) scripts/supabase/check_connection.py

supabase-sync: ## Sincroniza dados do SIENGE para Supabase
	$(PYTHON) src/main.py sync

supabase-sync-full: ## Sincronização completa
	$(PYTHON) src/main.py sync --full

# SIENGE
sienge-test: ## Testa conexão com API SIENGE
	$(PYTHON) scripts/sienge/test_connection.py

sienge-explore: ## Explora endpoints da API SIENGE
	$(PYTHON) scripts/sienge/explore_api.py

# Monitoramento
logs: ## Mostra logs da aplicação
	tail -f logs/app.log

monitor: ## Inicia monitoramento
	$(PYTHON) src/monitoring/dashboard.py

# Limpeza
clean: ## Limpa arquivos temporários
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	rm -rf .coverage htmlcov/ .pytest_cache/

clean-docker: ## Limpa containers e volumes Docker
	$(DOCKER_COMPOSE) down -v
	docker system prune -f

# Deploy
deploy-staging: ## Deploy para staging
	@echo "Deploying to staging..."
	git push origin staging
	# Adicionar comandos de deploy específicos

deploy-prod: ## Deploy para produção
	@echo "Deploying to production..."
	git push origin main
	# Adicionar comandos de deploy específicos

# Backup
backup: ## Faz backup do banco de dados
	$(PYTHON) scripts/maintenance/backup_database.py

restore: ## Restaura backup do banco de dados
	@read -p "Arquivo de backup: " file; \
	$(PYTHON) scripts/maintenance/restore_database.py "$$file"

# Relatórios
report: ## Gera relatório de sincronização
	$(PYTHON) scripts/reports/sync_report.py

metrics: ## Mostra métricas do sistema
	$(PYTHON) scripts/reports/system_metrics.py 