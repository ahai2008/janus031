FROM openjdk:8-alpine
MAINTAINER ahai <lema360@qq.com>


# Install tools
RUN apk update && \
	apk add wget unzip git bash

# Install the server
RUN wget --no-check-certificate -O /janus.zip https://github.com/JanusGraph/janusgraph/releases/download/v0.3.1/janusgraph-0.3.1-hadoop2.zip && \
	unzip /janus.zip -d /janus && \
	rm /janus.zip
WORKDIR /janus/janusgraph-0.3.1-hadoop2

# Place where the graph is saved, see gremlin-graph.properties
RUN mkdir /graph_file

EXPOSE 8182

# Copy the configuration files and launch
COPY files .
RUN chmod 700 startup_commands.sh
CMD ["./startup_commands.sh"]
