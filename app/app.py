#!/usr/bin/python3
from flask import Flask
import platform
import json

#App definition
app = Flask(__name__)

@app.route('/osinfo')
def get_data():
    # Get system information
    system_info = {
        'platform': platform.platform(),
        'release': platform.release(),
        'system': platform.system(),
        'architecture' : platform.machine(),
        'python_version' : platform.python_version(),
        'node': platform.node(),
    }

    # Convert the data to JSON format
    json_data = json.dumps(system_info, indent=2)

    # Set up the HTTP response with the appropriate header
    response = app.response_class(
        response=json_data,
        status=200,
        mimetype='application/json'
    )

    return response

#if __name__ == '__main__':
#    app.run(debug=True,host="0.0.0.0",port="5000")
