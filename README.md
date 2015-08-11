Spooner
=======

Project Setup
-------------

> It is recomeded to use Vagrant virtualisation tool for setting up development enviroment

+ Clone the repository
+ Run: `vagrant up`
+ SSH to Vagrant machine: `vagrant ssh`
+ Once on the guea machine, start the unciorn server, by running the daemon: `sudo service unicorn start`

###### Troubleshooting
If for some reason unicorn daemon wont start try, purging system ruby on the guest machine: `sudo aptitude purge ruby`. For more details check the logs in `/var/www/unicorn/log/`. 

If there is a dependencies problem try runing `gem install bundler` on the guest machine, and then `rbenv rehash` to reload bundler in $PATH.


