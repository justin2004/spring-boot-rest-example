FROM debian:9
RUN apt-get update && apt-get install -y maven openjdk-8-jdk wget git
WORKDIR /root
RUN wget 'https://abcl.org/releases/1.6.0/abcl-bin-1.6.0.tar.gz' && tar -xaf abcl-bin-1.6.0.tar.gz
RUN touch /root/.abclrc

# you could probably use slime directly but since i use vim i'll just
# use slimv since it has slime in it
RUN git clone https://github.com/kovisoft/slimv.git

WORKDIR /mnt
