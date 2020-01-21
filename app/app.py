#!/usr/bin/env python3
from flask import Flask, render_template, request, redirect, flash, url_for, jsonify
import settings

# flask app and db settings
# TODO: settings should be read from encrypted file in production
app = Flask(__name__)
app.secret_key = 'not_for_production'

def init_app():
    """ Runs prior to app launching, contains initialization code """

@app.route('/')
def index():
    username = settings.USERNAME
    password = settings.PASSWORD

    return render_template('index.html', username=username, password=password)


if __name__ == "__main__":
    init_app()
    app.run(host='0.0.0.0', port=9000, debug=False)
