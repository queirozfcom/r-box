## R-BOX

This is a simple (Ubuntu-based) box you can use as a ready-made solution to start developing with (or learning) R.

(I've created this in order to have a clean environment in which to work with R for the Coursera Data Science Specialization (https://www.coursera.org/specialization/jhudatascience/1).

In order to get a fully functional Ubuntu VM with some starting tools for you to work on R you (just) need to:

 - Download VirtualBox
 - Download Vagrant
 - Download (or `git clone`) this project and then run `vagrant up` in the directory where you downloaded it. 
 
**Once you start the process `vagrant up`) it will probably take some time (maybe 20 to 30 mins) to download the image and all the dependencies.**

**Don't touch the VM until it looks like this:**

![VM Screenshot](http://i.imgur.com/LlYg51u.png)


Once it does, login using username/password = vagrant/vagrant.

In addition to the base Ubuntu (14.04 LTS) box, these are some things that get added:

- XFCE Lightweight GUI
- R (Version 3.X)
- RStudio
- Google Chrome Browser
