dump:
	docker-compose exec mariadb sh -c "mysqldump -h mariadb -u user -pzeus --databases database" > sql/dump.sql

import:
	docker-compose exec -T mariadb sh -c "mysql -h mariadb -u user -pzeus" < sql/dump.sql