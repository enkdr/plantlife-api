## plantlife-api

Contained api served by Go and Sqlite on port :8080

docker run -d -p 8080:8080 --name plantlife-api-container plantlife-api

infra directory has been excluded

For AWS:
Push to ECR and create App Runner task to deploy
