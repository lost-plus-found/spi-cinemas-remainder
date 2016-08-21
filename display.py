import urllib2
from bs4 import BeautifulSoup
from prettytable import PrettyTable

page = open('./movie.html', 'r').read()
soup = BeautifulSoup(page, "lxml")
result = soup.find("section",{"class" : "movie__listing now-showing" })

t = PrettyTable(['Movie Name'])
for li in result.find_all('li')[:-1]:
	div = li.find('div')
	dl = div.find('dl')

	dt = dl.find('dt')
	movie = dt.find('a')
	#print movie
	t.add_row([movie.text])
print t
print "\n"
	
