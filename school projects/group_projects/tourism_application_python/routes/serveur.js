/*
 * server.js
 *
 */


const app = require("express")()
const { spawn, execSync } = require('child_process')
const { range } = require("express/lib/request")

/*
app.get('/populartimes/moyenne/:heure', (req, res) => {

	//let python = spawn('python3', ['popTimes.py'])

	//python.stdout.on('data', function (data) {
	//	console.log('Python is called for populartimes')
	//	data_send = data.toString()

	//	python.on('close', (code) => {
	//		console.log('inside onclose with ' + data_send)
	//		console.log(data_send)
	//		res.send(data_send)
	//	})
		
	//	console.log('after onclose')

	})
	


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
	res.send(data_senp)

})

app.get('/populartimes/now', (req, res) => {

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
	res.send(data_sending)

})

app.get('/meteo/:info', (req, res) => {
	
	if (req.params.info == 'temperature')
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
				res.send(data_senp)
			})
		})
	}
	else if (req.params.info == 'ensoleillement')
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
				res.send(data_senp)
			})
		})	
	}
	else
	{
		res.send("Travail en cours ; We're waiting for Tristan !")
	}
})
*/

//Algorithme de recommandation des Visites
app.get('/visits/:mailAdressID/:lat/:long', (req, res) => {
	console.log("L'utilisateur " + req.params.mailAdressID + " interroge l'algorithme de recommandation des visites.")
	profilPositionInTable = -1
	for (i = 0 ; i < taille_profil_Table + 1 ; i++)
	{
		if (correspondanceTable[i] == req.params.mailAdressID)
		{
			profilPositionInTable = i
		}
	}	
	if (profilPositionInTable < 0)
	{
		let python = spawn('python3', ['../src/main.py', req.params.lat, req.params.long, 1, 1,	1, 1, 1, 0, 0, 0])
		python.stdout.on('data', function (data) {
			data_send = data.toString()
			data_sent = data_send.slice(0,-2)
			python.on('close', (code) => {
				res.send(data_sent)
				console.log(data_sent)
			})
		})
	}
	else
	{
		let python = spawn('python3', ['../src/main.py', req.params.lat, req.params.long, profilsTable[profilPositionInTable][2], profilsTable[profilPositionInTable][3], profilsTable[profilPositionInTable][4], profilsTable[profilPositionInTable][5], profilsTable[profilPositionInTable][6], profilsTable[profilPositionInTable][7]])
		python.stdout.on('data', function (data) {
			data_send = data.toString()
			data_sent = data_send.slice(0,-2)
			python.on('close', (code) => {
				res.send(data_sent)
				console.log(data_sent)
			})
		})
	}

	/* Il s'agit de la fonction de base
	let python = spawn('python3', ['../src/main.py', req.params.lat, req.params.long, profilsTable[profilPositionInTable][0], profilsTable[profilPositionInTable][1],	profilsTable[profilPositionInTable][2], profilsTable[profilPositionInTable][3], profilsTable[profilPositionInTable][4], profilsTable[profilPositionInTable][5], profilsTable[profilPositionInTable][6], profilsTable[profilPositionInTable][7]])
	python.stdout.on('data', function (data) {
		data_send = data.toString()
		data_sent = data_send.slice(0,-2)
		python.on('close', (code) => {
			res.send(data_sent)
			console.log(data_sent)
		})
	})
	*/
})

//Profils

profilsTable = [[]] //Table contenant les informations sur les paramètres d'appréciation de chaque utilisateur (les 'b')
correspondanceTable = []
taille_profil_Table = 0
MdP_Profil_Table = []

app.get('/profilExistence/:mailAdressID', (req, res) => {
	bolAnswer = 'False'
	console.log("Quelqu'un demande qq chose")
	for (i = 0 ; i < taille_profil_Table + 1 ; i++)
	{
		if (correspondanceTable[i] == req.params.mailAdressID)
		{
			bolAnswer = 'True'
			break
		}
	}
	res.send(bolAnswer)
})

app.get('/profilCreation/:username/:mailAdressID/:password/:popularityB/:meteoB/:temperatureB/:localisationB/:affluenceB/:priceB', (req, res) => {
	taille_profil_Table += 1
	correspondanceTable[taille_profil_Table] = req.params.mailAdressID
	MdP_Profil_Table[taille_profil_Table] = req.params.password
	profilsTable[taille_profil_Table] = []
	profilsTable[taille_profil_Table][0] = req.params.mailAdressID
	profilsTable[taille_profil_Table][1] = req.params.username
	profilsTable[taille_profil_Table][2] = req.params.popularityB
	profilsTable[taille_profil_Table][3] = req.params.meteoB
	profilsTable[taille_profil_Table][4] = req.params.temperatureB
	profilsTable[taille_profil_Table][5] = req.params.localisationB
	profilsTable[taille_profil_Table][6] = req.params.affluenceB
	profilsTable[taille_profil_Table][7] = req.params.priceB
	console.log("Profil bien créé : " + req.params.mailAdressID)
	res.send("Profil bien créé : " + req.params.mailAdressID)
})

app.get('/profilConnection/:mailAdressID/:password', (req, res) => {
	bolAnswer = 'False'
	console.log("Quelqu'un veut se connecter")
	for (i = 0 ; i < taille_profil_Table + 1 ; i++)
	{
		if (correspondanceTable[i] == req.params.mailAdressID)
		{
			bolAnswer = 'True'
			break
		}
	}
	if (bolAnswer == 'False')
	{
		res.send(bolAnswer)
		console.log("Adresse incorrecte pour la connection")
		return
	}
	ouCest = 0
	for (i = 0 ; i < taille_profil_Table + 1 ; i++)
	{
		if (correspondanceTable[i] == req.params.mailAdressID)
		{
			ouCest = i
			break
		}
	}
	if (MdP_Profil_Table[ouCest] == req.params.password)
	{
		res.send(profilsTable[ouCest][1] + "_" + profilsTable[ouCest][2] + "_" + profilsTable[ouCest][3] + "_" + profilsTable[ouCest][4] + "_" + profilsTable[ouCest][5] + "_" + profilsTable[ouCest][6] + "_" + profilsTable[ouCest][7])
		console.log("C'est bon, connection réussie")
	}
	else
	{
		res.send('false')
		console.log("MdP faux")
	}
})

app.get('/profilEdition/:mailAdressID/:popularityB/:meteoB/:temperatureB/:localisationB/:affluenceB/:priceB', (req, res) => {
	ouCest = 0
	for (i = 0 ; i < taille_profil_Table + 1 ; i++)
	{
		if (correspondanceTable[i] == req.params.mailAdressID)
		{
			ouCest = i
		}
	}
	profilsTable[ouCest] = []
	profilsTable[ouCest][2] = req.params.popularityB
	profilsTable[ouCest][3] = req.params.meteoB
	profilsTable[ouCest][4] = req.params.temperatureB
	profilsTable[ouCest][5] = req.params.localisationB
	profilsTable[ouCest][6] = req.params.affluenceB
	profilsTable[ouCest][7] = req.params.priceB
	console.log("Profil bien modifié")
	res.send('True')
})

/*app.get('/profilViewing/:mailAdressID', (req, res) => {
	ouCest = 0
	for (i = 0 ; i < taille_profil_Table + 1 ; i++)
	{
		if (correspondanceTable[i] == req.params.mailAdressID)
		{
			ouCest = i
		}
	}
	console.log(profilsTable[ouCest][2] + "_" + profilsTable[ouCest][3] + "_" + profilsTable[ouCest][4] + "_" + profilsTable[ouCest][5] + "_" + profilsTable[ouCest][6] + "_" + profilsTable[ouCest][7])
	res.send(profilsTable[ouCest][2] + "_" + profilsTable[ouCest][3] + "_" + profilsTable[ouCest][4] + "_" + profilsTable[ouCest][5] + "_" + profilsTable[ouCest][6] + "_" + profilsTable[ouCest][7])
})*/

//Evènements

interestTable = [[]] //Table contenant les informations sur les différents évènements éphèmmères
idTable = []
taille_id_Table = 0
lastErasedEventIndice = 0

function eventObsolete(id)
{
	console.log("Suppression d'un évènement : id = " + id)
	lastErasedEventIndice += 1
}

app.get('/interest/:lat/:long/:name/:description', (req, res) => {
	exist = 'False'
	for (i = lastErasedEventIndice ; i < taille_id_Table ; i++)
	{
		if (((parseInt(req.params.lat) - parseInt(interestTable[i][1][1]))**2) + ((parseInt(req.params.long) - parseInt(interestTable[i][1][2])**2)) < 0.0001)
		{
			exist = 'True'
		}
	}
	//Pas plusieurs évènements au même endroit
	if (exist == 'True')
	{
		res.send('False')
		console.log("Un évènement est déjà créé dans les environs... (Position : " + req.params.lat + ", " + req.params.long + ")")
	}
	else
	{
		res.send('True')
		idTable[taille_id_Table] = taille_id_Table
		console.log("Creation of event : " + req.params.name + " (id = " + idTable[taille_id_Table] +")")
		interestTable[taille_id_Table] = []
		interestTable[taille_id_Table][0] = taille_id_Table
		interestTable[taille_id_Table][1] = []
		interestTable[taille_id_Table][1][0] = req.params.name
		interestTable[taille_id_Table][1][1] = req.params.description
		interestTable[taille_id_Table][1][2] = req.params.lat
		interestTable[taille_id_Table][1][3] = req.params.long
		taille_id_Table += 1
		setTimeout(function(){eventObsolete(lastErasedEventIndice)}, 60000) //Durée de vie d'un évènement : 1 minute
	}
})

app.get('/interest/update', (req, res) => {
	temporaryEvents = ''
	console.log('Une update des évènements temporaires est demandée !')
	for (i = lastErasedEventIndice ; i < taille_id_Table ; i++)
	{
		temporaryEvents = temporaryEvents + interestTable[i][1][0].toString() + "_" + interestTable[i][1][1].toString() + "_" + interestTable[i][1][2].toString() + "_" + interestTable[i][1][3].toString() + ";"
	}
	tempEventsSent = temporaryEvents.slice(0,-1)
	console.log(tempEventsSent)
	res.send(tempEventsSent)
})

//Espace commentaires
app.get('/interest/:idEvenement/:message', (req, res) => {
	positionEvent = 0
	tailleEvent = 0
	text = ""
	while (idTable[positionEvent][0] != req.params.idEvenement)
	{
		positionEvent += 1
	}
	while (interestTable[positionEvent][1][tailleEvent] != null)
	{
		text += interestTable[positionEvent][1][tailleEvent]
		text += " "
		tailleEvent += 1
		console.log("Another comment : " + interestTable[positionEvent][1][tailleEvent])
	}
	interestTable[positionEvent][1][tailleEvent] = req.params.message

	res.send(text + req.params.message)
})

//Test n° 1
app.get('/', (req, res) => {
	res.send("Reçu");
	console.log("Recu");
})

//Test n° 2
app.get('/:name', (req, res) => {

	if (req.params.name == 'test')
	{
		res.send("ok");
		console.log("ok");
	}
	else
	{
		res.send(`Vous avez envoyé : ${req.params.name}`)
	}
});

//listen for requests :)
app.listen(80, () => {
	console.log("Started on port 80...");
})