#!/usr/bin/env bash

# for some reason if the fasl directory in here exists with contents from a previous 
# startup swank will not start properly
rm -rf /root/.slime

# make a jar for the interloper
cd other/src && javac com/interloper/Interloper.java && jar cf interloper.jar com/

cd /mnt 
mvn clean package
# thanks to https://stackoverflow.com/questions/39716796/spring-boot-executable-jar-with-classpath
java -cp 'target/spring-boot-rest-example-0.5.0.jar:/root/abcl-bin-1.6.0/abcl.jar:/mnt/other/src/interloper.jar' \
    -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 \
    -Ddebug \
    -Dspring.profiles.active=test \
    -Dloader.main=com.khoubyari.example.Application \
    org.springframework.boot.loader.PropertiesLauncher

