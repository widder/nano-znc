Nano ZNC
========

To setup the ZNC server :

```
#> docker run -d --name zncdata -v /data widder/nano-znc /bin/ls
#> docker run -i -t --user="znc" --volumes-from=zncdata widder/nano-znc --makeconf
```

To start the server:

```
#> docker run -d --user="znc" --name znc --volumes-from=zncdata -p 6697:6697 widder/nano-znc -f
```

ZNC 1.6.0 :

  - With ICU
  - Python 3.4.6
  - Perl 5.20
