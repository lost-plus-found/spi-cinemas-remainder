#!/bin/bash

curl -s https://www.spicinemas.in/chennai/now-showing > movie.html
python spi.py
