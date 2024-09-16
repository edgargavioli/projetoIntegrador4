docker build -t crautor/controledeestoque .

// maven -> clean -> install

docker run -d --name crautor/controledeestoque -p 8080:8080 --restart unless-stopped crautor/controledeestoque

docker network create minha-rede

docker run --name bancodedados --network minha-rede -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root -d mysql

docker run -d --name crautor/controledeestoque --network minha-rede -p 8080:8080 --restart unless-stopped crautor/controledeestoque

spring.datasource.url=jdbc:mysql://54.234.58.60:3306/controle_de_estoque?useSSL=false&serverTimezone=UTC-3

