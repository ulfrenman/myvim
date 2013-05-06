all: submodules links

submodules:
	git submodule init
	git submodule update

links:
	ln -sfn ${CURDIR}/vimrc ~/.vimrc
	ln -sfn ${CURDIR} ~/.vim

update_modules:
	git submodule foreach git pull origin master
