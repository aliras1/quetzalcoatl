FROM maven:3.6-jdk-11 as maven_build

WORKDIR /app

COPY ./caffapplication/pom.xml .
#resolve maven dependencies
RUN mvn clean package -Dmaven.test.skip -Dmaven.main.skip -Dspring-boot.repackage.skip && rm -r target/
#copy source
COPY ./caffapplication/src ./src
# build the app (no dependency download here)
RUN mvn clean package  -Dmaven.test.skip

FROM openjdk:11.0-jre
RUN apt update
RUN apt install -y build-essential


RUN mkdir /app
WORKDIR /caff
COPY src/caff_parser/CAFFParser /caff
RUN g++ ByteReader.cpp CAFFdto.cpp CIFFdto.cpp JsonUtil.cpp CAFFParser.cpp Main.cpp -o /app/CAFFParser
COPY --from=maven_build /app/target/caffapplication-0.0.1-SNAPSHOT.jar /app/caffapplication-0.0.1-SNAPSHOT.jar

#run the app
WORKDIR /app
RUN mkdir /app/gifs
CMD java -jar /app/caffapplication-0.0.1-SNAPSHOT.jar