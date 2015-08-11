Spooner
=======

Project Setup
-------------

> It is recomeded to use Vagrant virtualisation tool for setting up development enviroment

+ Clone the repository
+ Run: `vagrant up`
+ SSH to Vagrant machine: `vagrant ssh`
+ Once on the guest machine, start the unciorn server, by running the daemon: `sudo service unicorn start`

#### Troubleshooting
> If for some reason unicorn daemon wont start try, purging system ruby on the guest machine: `sudo aptitude purge ruby`. For more details check the logs in `/var/www/unicorn/log/`.


> If there is a dependencies problem try runing `gem install bundler` on the guest machine, and then `rbenv rehash` to reload bundler in $PATH.

Game Introduction
-----------------

Spooners is a life game for unlimited numbers of players. It can be played any time, anywhere, in any occasion. In principle Spooners is an elaborated tag game, which trough simple yet intriguing game mechanics, offers a little more competative and fun gaming envirorment. 

> **Spooners is not a digital product, it is a game concept, simple a set of rules that all participants need agree to in order the  game to function.**

Since there can be a lot of participants per game session, there is a lot of statistical and boring data that the session moderator needs to follow, there is also the need for the game participants to communicate with the game moderator. This is where internet and modern digital solutions can be used to reach a certain market and consumers. 

> **The idea is to allow the consumer to play this simple game using various web and mobile apps. While web platfrom would be free to use, revenue would be achived on the mobile platforms, specificlly, trough in app purchases.** 

Product Development
-------------------



