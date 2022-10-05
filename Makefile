# This makefile is just a set of basic recipes, so I do not forget how to do things

docker-image: Docker/Dockerfile
	cd Docker; docker build --build-arg CACHE_DATE=$$(date +%Y-%m-%d_%H:%M:%S) -t ambs/loris .; cd -

push-docker-image:
	docker push ambs/loris

