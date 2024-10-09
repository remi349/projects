const { spawn, execSync } = require('child_process')

function meteoTemperature()
{
    let python = spawn('python3', ['meteo.py'])

		python.stdout.on('data', function (data) {
			console.log('Python is called for meteo')
			data_send = data.toString()

			python.on('close', (code) => {
				const indexOfFirst = data_send.indexOf('temp')
				data_sent = data_send.substr(indexOfFirst+7, 3)
				data_sending = parseInt(data_sent) - 273
				data_senp = data_sending.toString()
				console.log(data_senp)
				return data_senp
			})
		})
}

meteoTemperature()

function meteoEnsoleillement()
{
    let python = spawn('python3', ['meteo.py'])

		python.stdout.on('data', function (data) {
			console.log('Python is called for meteo')
			data_send = data.toString()

			python.on('close', (code) => {
				const indexOfFirst = data_send.indexOf('all');
				data_sent = data_send.substr(indexOfFirst+6, 2) //ATTENTION C'EST CHAUD (genre si c'est pas un pourcentage à deux chiffres)
				if (data_sent.includes("}"))
				{
					data_sending = 100 - parseInt(data_sent.substr(0, 1))
				}
				else
				{
					data_sending = 100 - parseInt(data_sent) //Ok, c'est cool
				}
				data_senp = data_sending.toString()
				return data_senp
			})
		})	
}

function populartimesNow()
{
    const shell = execSync("/usr/bin/python3 popTimes.py", {encoding: 'utf8'})
	data_send = shell.toString()
	const indexOfFirst = data_send.indexOf('current_popularity')
	data_sent = data_send.substr(indexOfFirst+21, 2)
	if (data_sent.includes(","))
				{
					data_sending = data_sent.substr(0, 1)
				}
				else
				{
					data_sending = data_sent //Ok, c'est cool
				}
	return data_sending
}

function populartimesMoyenne(heure)
{
    const shell = execSync("/usr/bin/python3 popTimes.py", {encoding: 'utf8'})
	data_send = shell.toString()
	compteur = 0
	mean = 0

	indexOfFirst = data_send.indexOf('Monday')
	donnees = data_send.substr(indexOfFirst+17, 100)
	result = donnees;
	let parts = result.split(",")
	console.log(parts + " Ligne 36")
	output = parts[parseInt(req.params.heure)]
	console.log(output + " Ligne 38")
	if (output != 0)
	{
		mean = mean + parseInt(output)
		compteur += 1
	}

	indexOfFirst = data_send.indexOf('Tuesday')
	donnees = data_send.substr(indexOfFirst+18, 100)
	result = donnees;
	parts = result.split(",")
	output = parts[parseInt(req.params.heure) + 1]
	if (output != 0)
	{
		mean = mean + parseInt(output)
		compteur += 1
	}

	indexOfFirst = data_send.indexOf('Wednesday')
	donnees = data_send.substr(indexOfFirst+20, 100)
	result = donnees;
	parts = result.split(",")
	output = parts[parseInt(req.params.heure) + 1]
	if (output != 0)
	{
		mean = mean + parseInt(output)
		compteur += 1
	}

	indexOfFirst = data_send.indexOf('Thursday')
	donnees = data_send.substr(indexOfFirst+19, 100)
	result = donnees;
	parts = result.split(",")
	output = parts[parseInt(req.params.heure) + 1]
	if (output != 0)
	{
		mean = mean + parseInt(output)
		compteur += 1
	}

	indexOfFirst = data_send.indexOf('Friday')
	donnees = data_send.substr(indexOfFirst+17, 100)
	result = donnees;
	parts = result.split(",")
	output = parts[parseInt(req.params.heure) + 1]
	if (output != 0)
	{
		mean = mean + parseInt(output)
		compteur += 1
	}

	indexOfFirst = data_send.indexOf('Saturday')
	donnees = data_send.substr(indexOfFirst+19, 100)
	result = donnees;
	parts = result.split(",")
	output = parts[parseInt(req.params.heure) + 1]
	if (output != 0)
	{
		mean = mean + parseInt(output)
		compteur += 1
	}

	indexOfFirst = data_send.indexOf('Sunday')
	donnees = data_send.substr(indexOfFirst+17, 100)
	result = donnees;
	parts = result.split(",")
	output = parts[parseInt(req.params.heure) + 1]
	if (output != 0)
	{
		mean = mean + parseInt(output)
		compteur += 1
	}
	
	if (compteur != 0)
	{
		mean = Math.trunc(mean/compteur)
	}
	console.log(shell)
	data_senp = mean.toString()
	return data_senp
}