## What

Have you ever needed to provide nmap scan data in an easily understandable format? Have you noticed how hard it is to do?  So did I! 
So I hacked together these tools using [Namp Grepable Output](https://nmap.org/book/output-formats-grepable-output.html), A bash script to convert it to a CSV and some [D3.js code](https://d3js.org/).

## How

Runnig this is as easy as:

#### Nmap Your Target:
`nmap -sV jerrygamblin.com -oG scan.gnamp`

#### Transform the data to a CSV:
`./nmapcsv.sh scan.gnamp > data.csv`

#### Enjoy the data:
`http-server ~/nmaptable`

![Screenshot](https://raw.githubusercontent.com/jgamblin/nmaptable/master/Screen%20Shot%202017-09-07%20at%208.13.00%20PM.png)

## Demo? 

You want a Demo? [Here you go!](http://htmlpreview.github.io/?https://raw.githubusercontent.com/jgamblin/nmaptable/master/nmap.html)

## You want more?

I added a shell script that will allow you to contiously scan your targets and update the webpage.  Edit the varaibles in continuousscan.sh and run it in a screen session. 

`screen -s scan`

`./continuousscan.sh`

`ctrl+a d`
