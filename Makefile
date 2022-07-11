COMMIT_ID := $(shell git log|head -n1|awk '{print $$2}'|head -c 8)
all: build login tag push
build:
	docker build -t lab1-udemy-make:$(COMMIT_ID) .
login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 712012797855.dkr.ecr.us-east-1.amazonaws.com
tag:
	docker tag lab1-udemy-make:$(COMMIT_ID) 712012797855.dkr.ecr.us-east-1.amazonaws.com/kube-test-lab:$(COMMIT_ID)
	docker tag lab1-udemy-make:$(COMMIT_ID) 712012797855.dkr.ecr.us-east-1.amazonaws.com/kube-test-lab:latest
push:
	docker push 712012797855.dkr.ecr.us-east-1.amazonaws.com/kube-test-lab:$(COMMIT_ID)
	docker push 712012797855.dkr.ecr.us-east-1.amazonaws.com/kube-test-lab:latest
