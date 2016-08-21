#!/bin/bash

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
	while [ "$result" = "" ]
	do
		result=`curl -s https://www.spicinemas.in/chennai/now-showing | grep "$movie"`
	done
	#Remaind him using IFTTT
else
	echo ""
	echo "Hey! $USER, $movie is already showing in SPI Cinemas"
	echo "Check it out here, https://www.spicinemas.in/chennai/now-showing/"
	echo ""
fi
