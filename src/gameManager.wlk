import wollok.game.*
import Jugador.*
import Score.*
import Disparos.*

object gameManager {
	var totalScore = 0
	const scoreNumberUnidades = new Score(
		position = game.at(2, 14),
		image= 'assets/' + totalScore.toString() + '.png'
	)
	const scoreNumberDecenas = new Score(
		position = game.at(1, 14),
		image= 'assets/' + totalScore.toString() + '.png'
	)
	const scoreNumberCentenas = new Score(
		position = game.at(0, 14),
		image= 'assets/' + totalScore.toString() + '.png'
	)
	
	const enemigos = []
	var direccion = 1
	
	method enemigos() = enemigos
	method direccion() = direccion
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
	
	method generarEnemigos(x, y){
		const fila = 12-y
		if(x.between(2, 10) && fila <= 13){
			const enemigo = new Enemigo(position = game.at(x, fila), image = "assets/enemigo.png", vida = 1)
			enemigos.add(enemigo)	

			game.addVisual(enemigo)
			console.println(self.enemigos().size())
			self.generarEnemigos(x+1, y)	
		}else if(x == 11  && fila <= 13){
			self.generarEnemigos(2, y-1)
		}
	}
	
	method empezar(){
		game.addVisual(scoreNumberUnidades)
		game.addVisual(scoreNumberDecenas)
		game.addVisual(scoreNumberCentenas)
		self.generarEnemigos(2, 1)
		
		game.onTick(500, 'moverEnemigos', { 
			self.moverEnemigos()
		})
		
		game.onTick(disparoEnemigo.speed(), 'dispararEnemigos', { 
			self.dispararEnemigo()
		})
		
		game.onTick(10000, "avanzarEnemigos",{
			self.avanzarEnemigos()
		})
		
	}
	
	method moverEnemigos(){
		enemigos.forEach({enemigo =>
			enemigo.position(enemigo.position().right( direccion ))
		})
		if(enemigos.any({e => e.position().x() == 12}) || enemigos.any({e => e.position().x() == 0})){
			direccion *= -1
		}
	}
	
	method avanzarEnemigos(){
		if(enemigos.any({e => e.position().y() == 7})){
			game.removeTickEvent("avanzarEnemigos")
		}else{
			enemigos.forEach({enemigo =>
				enemigo.position(enemigo.position().down(1))
			})
		}
	}
	
	method dispararEnemigo(){
		const enemigosVivos = enemigos.filter{enemigo => enemigo.vida()>0}
		const filaDeAbajo = enemigosVivos.min({enemigo => enemigo.position().y()}).position().y() //Obtengo el enemigo cuya posicion en "y" es la mas baja y luego obtengo el valor de esta
		const enemigosPosibles = enemigosVivos.filter{enemigo => enemigo.position().y() == filaDeAbajo}
		const enemigo = enemigosPosibles.anyOne()
		enemigo.disparar()
	}
	
	method gameOver(){
		game.clear()
		self.empezar()
	}
	
	method validarCantidadEnemigos(){
		if(enemigos.isEmpty()){
			self.gameOver()
		}
	}
	
	
}
