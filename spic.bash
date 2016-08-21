#!/bin/bash

if [ "$1" = "-k" ]
then
	kill -9 `ps aux | grep "remainder.bash" | awk '{print$2}' | head -1`
	rm remainder.bash
	exit 0
fi

echo ""
echo "Hi! Welcome to SPI Cinemas Movie Remainder"
echo "Please make sure the movie spelling is right using google!"
echo -n "=> "

read mov
movie=`echo $mov | tr '[:lower:]' '[:upper:]'`
echo ""
echo "Please be patient, this may take some moment"
echo ""

result=`curl -s https://www.spicinemas.in/chennai/now-showing | grep "$movie"`

if [ "$result" = "" ]
then
	echo ""
	echo "Hey! $USER, I'll remind you as soon as $movie is up!"
	echo ""
	echo '
		#!/bin/bash

		if [ $# -eq 1 ]
		then
        		result=`curl -s https://www.spicinemas.in/chennai/now-showing | grep "$1"`
        		while [ "$result" = "" ]
        		do
                		result=`curl -s https://www.spicinemas.in/chennai/now-showing | grep "$1"`
        		done
        	#Remaind him using IFTTT
		fi' > remainder.bash
		bash remainder.bash $movie &	
else
	echo ""
	echo "Hey! $USER, $movie is already showing in SPI Cinemas"
	echo "Check it out here, https://www.spicinemas.in/chennai/now-showing/"
	echo ""
fi
