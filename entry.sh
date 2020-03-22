#!/usr/bin/env bash

# for some reason if the fasl directory in here exists with contents from a previous 
# startup swank will not start properly
rm -rf /root/.slime

# make a jar for the interloper
cd other/src && javac com/interloper/Interloper.java && jar cf interloper.jar com/ || exit 1

cd /mnt/shared-dependencies
mvn clean compile assembly:single || exit 1

cd /mnt 
mvn clean package || exit 1

CLASSPATH="target/spring-boot-rest-example-0.5.0.jar"
CLASSPATH="$CLASSPATH:/root/abcl-bin-1.6.0/abcl.jar"
CLASSPATH="$CLASSPATH:/mnt/other/src/interloper.jar"
CLASSPATH="$CLASSPATH:/mnt/shared-dependencies/target/shared-things-1.0.0-jar-with-dependencies.jar"

java -cp "$CLASSPATH" \
    -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 \
    -Ddebug \
    -Dspring.profiles.active=test \
    -Dloader.main=com.khoubyari.example.Application \
    org.springframework.boot.loader.PropertiesLauncher

# thanks to https://stackoverflow.com/questions/39716796/spring-boot-executable-jar-with-classpath
