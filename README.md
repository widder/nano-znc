Nano ZNC
========

Docker >=1.6 is needed for this.

To setup the ZNC server :

```
#> make dir
#> make build
#> make config
```


Check if znc starts correctly
```
#> make test
```

To start the server:

```
#> make start
```

ZNC 1.6.0 :

  - With ICU
  - Colloquy push module
  - (Python 3.4.6) (see Dockerfile)
  - (Perl 5.20)
