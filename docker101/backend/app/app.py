from flask import Flask, jsonify, request
import os

app = Flask(__name__)

#Parametrizados
_custom_path = os.environ.get("CUSTOM_PATH") if os.environ.get("CUSTOM_PATH") is not None else ""
_version_api = os.environ.get('VERSION_API')
_mensaje = os.environ.get("MENSAJE") if os.environ.get("MENSAJE") is not None else "Hola BackEnd by SERCH!!!"
#Nativos
_hostname = os.environ.get('HOSTNAME')

# @app.route('/')
# def root():
#     return jsonify({'path': '/',
#                     "Host-Name": _hostname,
#                     'mensaje':_mensaje,
#                     'versionAPI':_version_api})

@app.route(_custom_path+'/health')
def health():
    return jsonify({'versionAPI':_version_api})

@app.route(_custom_path+'/status')
def status():
    return jsonify({'basePath':_custom_path,
                    'versionAPI':_version_api,
                    "Host-Name": _hostname,
                    'mensaje':_mensaje})

@app.route(_custom_path+'/factorial',methods=['POST'])
def customPath():
        
    if request.method == 'POST':
        valorFactorial = 0
        try:
            print({"valor: ":request.json['factorial']})
            valorFactorial = carlcularFactorial(request.json['factorial'])
        except errorValue:
            print("Se ha generado un error")
        else:
            return jsonify({'path': _custom_path+'/factorial',
                            'versionAPI':_version_api,
                            'valorFactorial':valorFactorial})
    else:
        return jsonify({'path': _custom_path+'/factorial', "errorMensaje":"Metodo no soportado para esta operacion."})

def carlcularFactorial(numeroFactorial):

    factorial = 1

    if numeroFactorial < 0:
        print("No se puede calcular el factorial de un numero negativo.")
    elif numeroFactorial == 0:
        print("El factorial de 0 es 1")
    else:
        for i in range(1,numeroFactorial + 1):
            factorial = factorial*i
        return("El factorial de "+str(numeroFactorial)+" es "+str(factorial))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)