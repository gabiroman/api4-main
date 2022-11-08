# API 4 - ABM Calendario

# Sección de import
from flask import Flask
from flask import render_template, request, redirect, url_for
from flask import jsonify
from flask_mysqldb import MySQL, MySQLdb
from datetime import datetime

# Creacion de app Flask

app = Flask(__name__)

# Parametrización de app Flask

app.secret_key = "cWpsv71Sq0LhRf9sDpOfJMMOYlxw"

# Parametrización de conexión MySQL / MariaDB
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'turnero'
app.config['MYSQL_PASSWORD'] = '4IlXG2owt0it'
app.config['MYSQL_DB'] = 'turnerodb'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'

mysql = MySQL(app)

# Routes
@app.route('/')
def index():
    return redirect(url_for('turnos'))

@app.route('/turnos')
def turnos():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT turnos_pacientes.id,turnos.fecha_inicio,turnos.fecha_fin, pacientes.dni, pacientes.apellidos, pacientes.nombres FROM turnos, pacientes,turnos_pacientes WHERE turnos_pacientes.turno_id=turnos.id AND turnos_pacientes.paciente_dni=pacientes.dni ORDER BY fecha_inicio')
    asignados = cur.fetchall()
    cur.close()
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM turnos WHERE NOT EXISTS (SELECT NULL FROM turnos_pacientes WHERE turnos_pacientes.turno_id=turnos.id)')
    disponibles = cur.fetchall()
    cur.close()
    return render_template('turnos.html',asignados = asignados,disponibles = disponibles)

@app.route('/turnos/fadd')
def formAsignarTurno():
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM turnos WHERE NOT EXISTS (SELECT NULL FROM turnos_pacientes WHERE turnos_pacientes.turno_id=turnos.id)')
    disponibles = cur.fetchall()
    cur.close()
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT pacientes.dni, pacientes.nombres, pacientes.apellidos FROM pacientes ORDER BY dni')
    pacientes = cur.fetchall()
    cur.close()
    return render_template('turnos_fadd.html', disponibles = disponibles, pacientes = pacientes)

@app.route('/turnos/add',methods=['POST'])
def asignarTurno():
    if request.method=='POST':
        turno = request.form['sel_turno']
        paciente = request.form['sel_paciente']
        #agregar control
        print(turno)
        print(paciente)
        #insertar
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('INSERT INTO turnos_pacientes (turno_id, paciente_dni) VALUES (%s, %s)',([turno],[paciente]))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('turnos'))

@app.route('/turnos/edit/<string:id>')
def editTurno(id):
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT turnos_pacientes.id,turnos.fecha_inicio,turnos.fecha_fin, pacientes.dni, pacientes.apellidos, pacientes.nombres FROM turnos,pacientes,turnos_pacientes WHERE turnos_pacientes.id=%s AND turnos_pacientes.paciente_dni=pacientes.dni AND turnos_pacientes.turno_id=turnos.id',[id])
    turno = cur.fetchall()
    cur.close()
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('SELECT * FROM turnos WHERE NOT EXISTS (SELECT NULL FROM turnos_pacientes WHERE turnos_pacientes.turno_id=turnos.id)')
    disponibles = cur.fetchall()
    return render_template('turnos_edit.html',turno=turno[0],disponibles=disponibles)

@app.route('/turnos/update/<id>',methods=['POST'])
def updateTurno(id):
    if request.method=='POST':
        turno = request.form['sel_turno']
        #Agregar control
        print(turno)
        cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cur.execute('UPDATE turnos_pacientes SET turno_id = %s WHERE turnos_pacientes.id=%s',([turno],[id]))
        mysql.connection.commit()
        cur.close()
        return redirect(url_for('turnos'))

@app.route('/turnos/delete/<string:id>')
def deleteTurno(id):
    cur = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cur.execute('DELETE FROM turnos_pacientes WHERE id = {0}'.format(id))
    mysql.connection.commit()
    cur.close()
    return redirect(url_for('turnos'))

# Inicializa
if __name__ == '__main__':
    app.run(debug=True)