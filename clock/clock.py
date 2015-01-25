#!/usr/bin/env python

from bottle import *
import datetime

FIFO_FILE = '/tmp/fifo'


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
    with open(FIFO_FILE, 'r') as fh:
        time = fh.readline().strip()
    now = datetime.datetime.now()
    return {
        "hours": now.hour,
        "minutes": now.minute,
        "seconds": now.second,
    }


if __name__ == "__main__":
    run(host='localhost', port=8080, debug=True)
