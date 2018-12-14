# Unix home dir configuration
## Git cloning
```
$ cd ~
$ git clone ...
$ cp -r home-config/. .
$ rm -rf home-config
```
## .vimrc
1. Install Vundle:
```
$ ./.vim/install.sh
```
2. Install Exuberant ctags: 
```
$ sudo apt-get install exuberant-ctags
```
3. Install plugins running the following command from vim:
```
:VundleInstall
```
