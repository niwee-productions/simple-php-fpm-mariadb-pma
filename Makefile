dump:
	docker-compose exec mariadb sh -c "mysqldump -h mariadb -u user -pzeus --databases database" > app/sql/dump.sql

import:
	docker-compose exec -T mariadb sh -c "mysql -h mariadb -u user -pzeus" < app/sql/dump.sql