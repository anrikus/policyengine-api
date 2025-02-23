install:
	pip install -e .

debug:
	FLASK_APP=policyengine_api.api FLASK_DEBUG=1 flask run --without-threads

test:
	pytest tests/api

debug-test:
	FLASK_DEBUG=1 pytest tests/api

format:
	black . -l 79

deploy:
	python gcp/export.py
	gcloud config set app/cloud_build_timeout 1200
	cp gcp/policyengine_api/* .
	y | gcloud app deploy --service-account=github-deployment-anrikus-dev@policyengine-infrastructure.iam.gserviceaccount.com --verbosity=debug
	rm app.yaml
	rm Dockerfile
	rm .gac.json
	rm .dbpw

changelog:
	# build-changelog changelog.yaml --output changelog.yaml --update-last-date --start-from 0.1.0 --append-file changelog_entry.yaml
	# build-changelog changelog.yaml --org PolicyEngine --repo policyengine-api --output CHANGELOG.md --template .github/changelog_template.md
	# bump-version changelog.yaml setup.py policyengine_api/constants.py
	# rm changelog_entry.yaml || true
	# touch changelog_entry.yaml

setup_filesystem:
	python gcp/export.py
	cp gcp/policyengine_api/* .
	echo .git >> .dockerignore

cleanup:
	rm -f .gac.json
	rm -f .dbpw
