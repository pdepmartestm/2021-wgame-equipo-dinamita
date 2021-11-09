import wollok.game.*
import Jugador.*
import Score.*
import Disparos.*
import enemigosManager.*

object gameManager {
	var totalScore = 0
	
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
		game.addVisual(scoreNumberUnidades)
		game.addVisual(scoreNumberDecenas)
		game.addVisual(scoreNumberCentenas)
		
		enemigosManager.generarEnemigos(2, 1)
		
		game.onTick(500, 'moverEnemigos', { 
			enemigosManager.moverEnemigos()
		})
		
		game.onTick(disparoEnemigo.speed(), 'dispararEnemigos', { 
			enemigosManager.dispararEnemigo()
		})
		
		game.onTick(10000, "avanzarEnemigos",{
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

object ganador {
	var property image = "ganaste.png"
	var property position = game.at(1,7)
}

object perder {
	var property image = "perdiste.png"
	var property position = game.at(1,7)
}
