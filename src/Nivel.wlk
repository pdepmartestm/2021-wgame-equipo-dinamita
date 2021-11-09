import wollok.game.*
import Jugador.*
import Score.*
import Disparos.*
import enemigosManager.*

class Nivel {
	var property velocidadEnemigos 
	var property velocidadDisparos
	var property velocidadAvance
	
	var totalScore = 0
	
	method totalScore() = totalScore
	
	method sumarPunto(){
		totalScore+=1
		
		const centenas = totalScore.div(100).toString()
		const decenas = (totalScore.div(10) % 10).toString()
		const unidades = (totalScore % 10).toString()
		
		scoreNumberUnidades.changeScoreImage(unidades.toString())
		scoreNumberDecenas.changeScoreImage(decenas.toString())
		scoreNumberCentenas.changeScoreImage(centenas.toString())
	}
	
	method empezar(){
		game.addVisual(scoreNumberUnidades)
		game.addVisual(scoreNumberDecenas)
		game.addVisual(scoreNumberCentenas)
		
		enemigosManager.generarEnemigos(2, 1)
		
		game.onTick(velocidadEnemigos, 'moverEnemigos', { 
			enemigosManager.moverEnemigos()
		})
		
		game.onTick(velocidadDisparos, 'dispararEnemigos', { 
			enemigosManager.dispararEnemigo()
		})
		
		game.onTick(velocidadAvance, "avanzarEnemigos",{
			enemigosManager.avanzarEnemigos()
		})
		
	}
	
	method gameOver(){
		try{
			game.removeTickEvent("moverEnemigos")
		} catch e : Exception{
			
		}
		game.removeTickEvent('dispararEnemigos')
		game.addVisual(ganador)
	}
	
	method gameOver2() {
		try{
			game.removeTickEvent("avanzarEnemigos")
		} catch e : Exception{
			
		}
		game.removeTickEvent('moverEnemigos')
		game.removeTickEvent('dispararEnemigos')
		usuario.eliminar()
		game.addVisual(perder)
		
	}	
}

object nivel1 inherits Nivel(
	velocidadEnemigos = 600, 
	velocidadDisparos = 600,
	velocidadAvance = 15000
){
	
}

object nivel2 inherits Nivel(
	velocidadEnemigos = 400, 
	velocidadDisparos = 400,
	velocidadAvance = 12000
){
	
}

object nivel3 inherits Nivel(
	velocidadEnemigos = 300, 
	velocidadDisparos = 300,
	velocidadAvance = 8000
){
	
}

object ganador {
	var property image = "ganaste.png"
	var property position = game.at(1,7)
}

object perder {
	var property image = "perdiste.png"
	var property position = game.at(1,7)
}
