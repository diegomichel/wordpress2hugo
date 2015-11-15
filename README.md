# Wordpress2Hugo converter
## Script to convert your [wordpress](http://wordpress.org) posts into markdown format to work with [gohugo.io](http://gohugo.io)

## You will need:
* A backup of your wordpress database (only the posts table is required).
* A Mysql server running with the database restored.

## Steps
* Open convert.rb with your favorite editor and edit under section Configuration
* Execute setup.sh to install the required gems(some may need external libraries.)
* One time setup.sh ends without errors execute convert.rb

All your posts will be generated ont he specified directorie and then you can move em to your hugo content/ folder.

Best regards.
