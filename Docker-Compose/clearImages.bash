# get all RC microservice images and delete them by their ID
docker images | grep 'restorecommerce' | grep '\-srv' | awk '{print $3}' | xargs docker rmi -f