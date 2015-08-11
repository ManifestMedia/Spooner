Spooner
=======

Project Setup
-------------

> It is recomeded to use Vagrant virtualisation tool for setting up development enviroment

+ Clone the repository
+ Run: `vagrant up`
+ SSH to Vagrant machine: `vagrant ssh`
+ Once on the guea machine, start the unciorn server, by running the daemon: `sudo service unicorn start`

#### Troubleshooting
_If for some reason unicorn daemon wont start try, purging system ruby on the guest machine: `sudo aptitude purge ruby`. For more details check the logs in `/var/www/unicorn/log/`._

_If there is a dependencies problem try runing `gem install bundler` on the guest machine, and then `rbenv rehash` to reload bundler in $PATH._

Game Introduction
-----------------
Spooners is a social role playing game for unlimited numbers of players. It can be played any time, anywhere, in any occasion. In principle Spooners is an elaborated tag game, which trough simple yet intriguing game mechanics, offers a little more competative and fun gaming envirorment. 

Spooners is not a digital product, it is simple a set of rules that all participants need agree to, in order the  game to function. In essence all what is needed is some paper and a pencile. But since there can be a lot of participants per game session there is a lot of statistical and boring data that the session moderator needs to follow, as well as need for the game participants to communicate with the game moderator. This is where internet and modern digital solutions can be used to reach a certain market and consumer. The idea is to allow the consumer to play this simple game using various web and mobile apps. While web platfrom would be free to use, revenue would be achived on the mobile platforms, specificlly, trough in app purchases. This will be elaborated in details in furthure texts.

When it comes to type of the cosumer spooner has no limits. It has been tested in it’s simplest form using emails and phones, and its fun! There were 20 participants so far ranging in the ages of 19 - 30 years, so in essence spooners can be played by 5th graders, or by a bunch of developers in the R&D department in Finland. So here is how it works


