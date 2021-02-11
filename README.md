# ft_server - @42Born2Code

L'objectif de ft_server est de créer un serveur web capable de faire tourner un wordpress, un phpmyadmin, et une base de données. Ce serveur tournera dans un containeur Docker, sous Debian Buster.

-CMD build: 

 $> docker build -t name .
 
-CMD run:

$> docker run -it -p 80:80 -p 443:443 name
