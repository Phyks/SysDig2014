#!/usr/bin/env python

from bottle import *
import sys

FIFO_FILE = '/tmp/fifo'
now = {"hours": 0, "minutes": 0, "seconds": 0}


@route('/')
def index():
    return template("index")


@route('/js/<filepath:path>')
def server_static_js(filepath):
    return static_file(filepath, root='js')


@route('/img/<filepath:path>')
def server_static_img(filepath):
    return static_file(filepath, root='img')


@route('/ajax/time')
def api_time():
    global now
    fifo = ""
    while not fifo.startswith("FIFO!!!!!!"):
        fifo = sys.stdin.readline()
    fifo = int(fifo.strip().split("!")[-1])
    if fifo & 0x40 == 0x40:  # minutes
        now['minutes'] = fifo & 0x3F
    elif fifo & 0x80 == 0x80:  # heures
        now['hours'] = fifo & 0x3F
    else:  # secondes
        now['seconds'] = fifo & 0x3F
    return now


if __name__ == "__main__":
    run(host='localhost', port=8080, debug=False, reloader=False)
