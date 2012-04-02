precajobs.net 
=============

Aplicación web donde los usuarios cuelgan, votan y comentan las ofertas más precarias en el mercado laboral. 

http://precajobs.net

Entorno de desarrollo
====================

Sistema Operativo: Ubuntu/Debian

1. En caso de no tenerlo instalado, instalar RVM: http://beginrescueend.com/rvm/install/
    $ sudo aptitude install curl
    $ bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
    $ rvm install 1.9.2 
2. Iniciar un gemset nuevo llamado precajobs e install bundler
    $ rvm gemset create precajobs
    $ rvm gemset use precajobs
3. En caso de no tener que ejecutar el gemset use cada vez que querramos trabajar en el proyecto, lo recomendable es crear este fichero .rvmrc en la raiz del proyecto
    $ echo "rvm 1.9.2@precajobs" > .rvmrc
    $ cd . 
Por último, aceptar el uso de este entorno.
4. Instalar las dependencias necesarias, tanto las gemas como el cutycap (para los screenshots)

$ bundle install 
$ sudo aptitude install xvfb cutycap

5. Crear la base de datos e iniciar el servidor web

$ rake db:create
$ rake db:migrate
$ unicorn_rails

6. Podrás acceder yendo a http://localhost:8080 - happy hacking!
