echo "CONTAINER NAME: $container_name"
docker exec -it $container_name mkdir -p /tyne-finance/scripts

for file in *.sql; do
	echo "Copying $file to docker container $container_name"
	docker cp "$file" $container_name:/tyne-finance/scripts/
done
