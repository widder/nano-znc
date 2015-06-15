dir:
        mkdir -p /opt/nano-znc/
        chown -R 5959:5959 /opt/nano-znc/
clean:
        docker rm -f znc
build:
        docker build -t widder/nano-znc .
conf:
        docker run -i -t --user="znc" -v /opt/nano-znc:/data widder/nano-znc --makeconf
test:
        docker run -i -t --user="znc" --name znc -v /opt/nano-znc:/data -p 6697:6697 widder/nano-znc -D
start:
        docker run -d --user="znc" --name znc -v /opt/nano-znc:/data -p 6697:6697 widder/nano-znc




