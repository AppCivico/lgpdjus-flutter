setup_google_services: ## Setup Firebase/Google Services
	./bin/setup-google-services.sh

bump_version: ## Bump app version
	./bin/bump-version.sh --commit-changes

beta: ## Publish package to beta channel
	./bin/publish.sh

release: ## Publish package to Stores
	./bin/publish.sh --release