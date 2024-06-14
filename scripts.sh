docker exec -it mysql-8 mkdir -p /tyne-finance/scripts

for file in *.sql; do
	echo "Copying $file to docker mysql-8"
	docker cp "$file" 'mysql-8':/tyne-finance/scripts/
done
