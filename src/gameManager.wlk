import wollok.game.*
import Jugador.*
import Score.*
import Disparos.*
import enemigosManager.*
import Nivel.*

object gameManager {
	var totalScore = 0
	const velocidad_enemigos = 1200
	const velocidad_disparos = 1200
	const velocidad_avance = 15000
	var nivel = 1
	
	
	method totalScore() = totalScore
	
	method sumarPunto(){
		totalScore+=1
		
		const centenas = totalScore.div(100).toString()
		const decenas = (totalScore.div(10) % 10).toString()
		const unidades= (totalScore % 10).toString()
		
		scoreNumberUnidades.changeScoreImage(unidades.toString())
		scoreNumberDecenas.changeScoreImage(decenas.toString())
		scoreNumberCentenas.changeScoreImage(centenas.toString())
	}
	
	method empezar(){
		const nuevoNivel = new Nivel(velocidadEnemigos = velocidad_enemigos / nivel, velocidadDisparos = velocidad_disparos / nivel, velocidadAvance = velocidad_avance / nivel)
		nuevoNivel.empezar()
	}
	
	method win(){
		nivel++
		try{
			game.removeTickEvent("moverEnemigos")
			game.removeTickEvent('dispararEnemigos')
		} catch e : Exception{
			
		}
		if(nivel > 3){
			game.addVisual(ganador)
		}else{
			const nuevoNivel = new Nivel(velocidadEnemigos = velocidad_enemigos / nivel, velocidadDisparos = velocidad_disparos / nivel, velocidadAvance = velocidad_avance / nivel)
			nuevoNivel.empezar()
		}
	}
	
	method lose() {
		try{
			game.removeTickEvent("avanzarEnemigos")
			game.removeTickEvent('moverEnemigos')
			game.removeTickEvent('dispararEnemigos')
		} catch e : Exception{
			
		}
		usuario.eliminar()
		game.clear()
		game.addVisual(perder)
		
	}
	
		
}

object ganador {
	var property image = "ganaste.png"
	var property position = game.at(1,7)
}

object perder {
	var property image = "perdiste.png"
	var property position = game.at(1,7)
}
