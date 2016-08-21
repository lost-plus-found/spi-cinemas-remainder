#/bin/bash

echo -n "Enter Email: "
read email
echo -n "Enter Password: "
read -s pass
echo ""

email=`echo $email | sed "s/@/%40/g"`
pass=`echo $pass | sed "s/@/%40/g" | sed "s/($)/%24/g" | sed "s/ /%20/g"`

curl -s -c c0.txt "https://www.spicinemas.in/oauth2/authorize?client_id=spi-web&redirect_uri=https://www.spicinemas.in/user/profile&response_type=spi_token&state=spi_start&isCallCenter=false" > /dev/null

curl -s -c c1.txt -b c0.txt --data "username=$email&password=$pass" "https://www.spicinemas.in/oauth2/login?isCallCenter=false" > /dev/null

curl -s -c c0.txt -b c1.txt "https://www.spicinemas.in/oauth2/authorize?client_id=spi-web&redirect_uri=https://www.spicinemas.in/user/profile&response_type=spi_token&state=spi_start&isCallCenter=false" > /dev/null

token=`cat c0.txt | grep spi | awk '{print$7}'`
key=`cat c1.txt | grep spi | awk '{print$7}'`

cookie="visited=1; cityName=chennai; spi.session.key=$key; spi_access_token=$token;"

rm *.txt

