#!/bin/bash 

existing_container=`docker ps  | grep -i web |  awk '{print $1}'`
red="\e[31m"
green="\e[32m"
blue="\e[34m"
noc="\e[0m"

echo -e "$blue ############checking for existing container..... $noc"
if [  -n ${existing_container} ]
 then
echo -e "$green found existing container and removing it....$noc"
docker rm -f ${existing_container} 2>&1 >/dev/null
echo -e "$green existing web container removed....$noc"
sleep 1 
echo -e  "$blue building image .... $noc"

docker build -t pullapantangi/ecomm_web:latest /root/robot-shop/web
docker push pullapantangi/ecomm_web:latest
docker run -dit --name web --restart always --network robo-shop -p 8000:8080 pullapantangi/ecomm_web:latest 
if [ $? == 0 ]
then
	echo -e "$green Container started successfully......$noc"
fi
else 
echo -e "$red #################### Not found any existing container....$noc"
echo -e  "$blue building image .... $noc"
docker build -t pullapantangi/ecomm_web:latest /root/robot-shop/web
docker push pullapantangi/ecomm_web:latest
docker run -dit --name web --restart always --network robo-shop -p 8000:8080 pullapantangi/ecomm_web:latest
if [ $? == 0 ]
then
        echo -e "$green Container started successfully......$noc"
fi

fi 


