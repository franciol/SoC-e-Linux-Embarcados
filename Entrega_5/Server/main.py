from flask import Flask, render_template, request
import os
import subprocess

app = Flask(__name__, static_folder='', static_url_path='')


@app.route("/", methods=['GET', 'POST'])
def index():
    print(request.method)
    if request.method == 'POST':
        if  request.form.get('Blink') == 'Blink':
            out = subprocess.Popen(['../hps_gpio', '1'], 
            stdout=subprocess.PIPE, 
            stderr=subprocess.STDOUT)
            stdout,stderr = out.communicate()
    return render_template("index.html")



@app.route('/button', methods=['GET'])
def get_btn():
    out = subprocess.Popen(['../hps_gpio', '0'], 
    stdout=subprocess.PIPE, 
    stderr=subprocess.STDOUT)
    stdout,stderr = out.communicate()
    BTN=(stdout.decode("utf-8") )
    return render_template('btn_state.html', btn_i=BTN)
        
       
        
   

if __name__ == '__main__':
    app.run(host='0.0.0.0')