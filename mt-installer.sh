#!/usr/bin/env bash
# Minetest Source Installation Debian-based (not including Ubuntu based)

# WARNING: Excessive comments and pseudocode because of who it was initially wrItten for! (A friend just learning! YAY!)

# First we need to see where this script was ran from because you can clone a script anywhere you want. We also need to set our current directory to our home directory for the dependancy gathering just for the sake of consistancy.

# Define our  starting directory.
START_DIRECTORY=./ # This will set the variable START_DIR to our current working directory at this point. Conventionally variables like that are written in ALL_CAPITALS_SNAKE_CASE because they are intended to be constant but there is no seperation of constants and variables in BASH. Also note it is not written as export START_DIR because this file is the only one that will need to use it.
# Now lets change directories to our home directory.
cd ~/ # Equivalent to $HOME/

# First thing is first, we need to get the best tool ever: Git! And we also need the GNU Compiler Collection C and C++ compilers, Lua and LuaJIT
sudo apt install git gcc g++ lua5.1 luajit # This will install all of these packages, if any are already installed it will just move on.

# Now we need the source code of Minetest. We will do this using our new superpowers given to us by git!
git clone https://github.com/minetest/minetest ./minetest-src # Clone the URL with the repository of Minetest into a folder in our home directory called minetest-src instead of the default ./minetest which might be confusing since Minetest uses ~/.minetest for non run-in-place builds on Linux.
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Breakdown of the above command:
#	The git clone command is used to clone a repository usually of
#		source code to your system. It defaults to cloning into
#		a directory which is named the last part of the URL (in
#		this case it would clone into ./minetest) It can be
#		cloned somewhere else though with an argument after the
#		url which is a path on your system you want it to go in
#		to.
#	We are cloning into ~/minetest-src (or ./minetest-src more
#		precisely, currently these are the same thing since our
#		home is our current directory) because if we used
#		~/minetest for our build it is easy to confuse with
#		~/.minetest which is where your Minetest data and mods
#		will go. I made that mistake and it is quite annoying
#		sometimes.

# Now on to getting more dependancies so we can build the game! NOTE: This way of writing a command is not exactly standard, it just reads better.
sudo apt install	build-essential \	# essential stuff
			libirrlicht-dev \	# Irrlicht: the engine the Minetest engine waas built on
			libgettextpo0 \		# Translation stuffs.
			libfreetype6-dev \	# Fonts.
			cmake \			# Build system.
			libbz2-dev \		# Bzip format headers.
			libpng-dev \		# PNG header.
			libjpeg-dev \		# JPEG headers.
			libxxf86vm-dev \	# No clue what this is but it is aa dependancy and a bunch of headers.
			libgl1-mesa-dev \	# OpenGL mesa headers.
			libsqlite3-dev \	# SQlite database headers.
			libogg-dev \		# OGG codec headers.
			libvorbis-dev \		# Vorbis OGG codec headers.
			libopenal-dev \		# OpenAL headers.
			libcurl4-openssl-dev \	# Curl4 openssl headers.
			libluajit-5.1-dev \	# LuaJIT headers.
			liblua5.1-0-dev \	# Lua headers.
			libleveldb-dev		# LevelDB headers
			# Missing redis headers.
			# Missing postgresql headers.
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# NOTE: THe above command should also install the libraries themselves since the headers depend on the libraries.

# Now we should be all set. Lets get to the actual building! For that we will run another script in this 
cd ./minetest-src/games # Enter the games directory of the Minetest source code we cloned so we can clone Minetest Game since Minimal is trash.

# Clone Minetest Game into ./minetest_game
git clone https://github.com/minetest/minetest_game

cd ../ # .. Means the parent directory, the directory that contains our current directory.

# Now lets get building! Time to let cmake come into play!
cmake . -DENABLE_GETTEXT=1 -DENABLE_FREETYPE=1 -DENABLE_LEVELDB=1 # Tell cmake to enable Gettext, Freetype, and LevelDB support for the configuration of the current directory.

# Now the fun part! Making the binary!

# Make it build!
make -j$(nproc) # That means run make using all cores.

sudo make install # Install it!
echo "Minetest installed! Have fun!"

# Go back to where we started
cd START_DIRECTORY/
