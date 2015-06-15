ZNC-Docker-Alpine Image
========================

Docker >=1.6 is needed for this!

Image size only ~50 MByte (without Python and Perl support)! 

Setup directory for the ZNC server :

```
#> make dir
```

Build and config the docker image:

```
#> make build
#> make config
```

Check if znc starts correctly (debug mode)
```
#> make test
#> make clean
```

To start the server:

```
#> make start
```

ZNC 1.6.0 :

  - With ICU
  - Colloquy push module
  - Playback module for Textual and Colloquy Mobile
  - (Python 3.4.6) (see Dockerfile)
  - (Perl 5.20)
