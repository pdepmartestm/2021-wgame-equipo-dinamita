import wollok.game.*
import Jugador.*
import Score.*
import Disparos.*
import gameManager.*

object enemigosManager {
	var property enemigos = []
	
	var property direccion = 1
	
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
	
	
	method moverEnemigos(){
		enemigos.forEach({enemigo =>
			enemigo.position(enemigo.position().right( direccion ))
		})
		if(enemigos.any({e => e.position().x() == 12}) || enemigos.any({e => e.position().x() == 0})){
			direccion *= -1
		}
	}
	
	method avanzarEnemigos(){
		if(enemigos.any({e => e.position().y() == 9})){
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
		enemigo.disparar(disparoEnemigo, "disparoEnemigo", -1)
	}
	
	method borrarEnemigo(enemigo){
		enemigos.remove(enemigo)
	}
	
	method validarCantidadEnemigos(){
		if(enemigos.isEmpty()){
			gameManager.win()
		}
	}
	
}
