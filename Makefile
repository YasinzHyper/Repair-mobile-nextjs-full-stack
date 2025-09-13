# Fix My Phone - Docker Management Makefile

.PHONY: help build up down dev prod logs clean reset health

# Default target
help: ## Show this help message
	@echo "Fix My Phone - Docker Commands"
	@echo "================================"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

# Environment setup
setup: ## Copy environment file and prepare for first run
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "✅ Created .env file from .env.example"; \
		echo "⚠️  Please edit .env with your actual credentials before running"; \
	else \
		echo "✅ .env file already exists"; \
	fi

# Development commands
dev: setup ## Start development environment with hot reload
	docker-compose -f docker-compose.dev.yml up --build

dev-bg: setup ## Start development environment in background
	docker-compose -f docker-compose.dev.yml up -d --build

# Production commands
build: ## Build all Docker images
	docker-compose build

up: setup ## Start production environment
	docker-compose up --build

prod: setup ## Start production environment with Nginx
	docker-compose --profile production up --build

prod-bg: setup ## Start production environment in background
	docker-compose --profile production up -d --build

# Management commands
down: ## Stop all services
	docker-compose down

stop: ## Stop services without removing containers
	docker-compose stop

restart: ## Restart all services
	docker-compose restart

logs: ## Show logs from all services
	docker-compose logs -f

logs-api: ## Show API logs only
	docker-compose logs -f api

logs-client: ## Show client logs only  
	docker-compose logs -f client

logs-db: ## Show database logs only
	docker-compose logs -f postgres

# Database commands
db-migrate: ## Run database migrations
	docker-compose exec api npx prisma migrate dev

db-reset: ## Reset database (⚠️ DESTRUCTIVE)
	docker-compose exec api npx prisma migrate reset --force

db-studio: ## Open Prisma Studio for database management
	docker-compose exec api npx prisma studio

db-shell: ## Access PostgreSQL shell
	docker-compose exec postgres psql -U fixmyphone_user -d fixmyphone

# Health and status
health: ## Check health of all services
	@echo "Checking service health..."
	@echo "Frontend: $$(curl -s -o /dev/null -w '%{http_code}' http://localhost:3000 2>/dev/null || echo 'DOWN')"
	@echo "Backend:  $$(curl -s -o /dev/null -w '%{http_code}' http://localhost:5051/api/v1/health 2>/dev/null || echo 'DOWN')"
	@echo "Database: $$(docker-compose exec postgres pg_isready -U fixmyphone_user 2>/dev/null | grep -q 'accepting' && echo '200' || echo 'DOWN')"

status: ## Show container status
	docker-compose ps

# Cleanup commands
clean: ## Remove stopped containers and unused images
	docker system prune -f

clean-all: ## Remove all containers, images, and volumes (⚠️ DESTRUCTIVE)
	docker-compose down -v --rmi all
	docker system prune -a -f

reset: clean-all setup ## Complete reset - remove everything and start fresh
	@echo "🔄 Complete reset completed. Run 'make dev' or 'make up' to start."

# Utility commands  
shell-api: ## Access API container shell
	docker-compose exec api sh

shell-client: ## Access client container shell
	docker-compose exec client sh

shell-db: ## Access database container shell
	docker-compose exec postgres sh

# Backup and restore
backup-db: ## Backup database to backup.sql
	docker-compose exec postgres pg_dump -U fixmyphone_user fixmyphone > backup.sql
	@echo "✅ Database backed up to backup.sql"

restore-db: ## Restore database from backup.sql (⚠️ DESTRUCTIVE)
	@if [ ! -f backup.sql ]; then \
		echo "❌ backup.sql not found"; \
		exit 1; \
	fi
	docker-compose exec -T postgres psql -U fixmyphone_user fixmyphone < backup.sql
	@echo "✅ Database restored from backup.sql"
