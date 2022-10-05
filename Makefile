# This makefile is just a set of basic recipes, so I do not forget how to do things

docker-image: Docker/Dockerfile
	cd Docker; docker build -t ambs/loris .; cd -


