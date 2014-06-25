all: make_master submodules update_modules links

submodules:
	git submodule init
	git submodule update

links:
	ln -sfn ${CURDIR}/vimrc ~/.vimrc
	ln -sfn ${CURDIR} ~/.vim

update_modules:
	git submodule foreach git pull origin master
	# Make sure the docs for the modules are generated
	vim -c 'call pathogen#helptags()|q'

make_master:
	git checkout master
