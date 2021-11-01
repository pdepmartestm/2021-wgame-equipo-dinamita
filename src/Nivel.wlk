import wollok.game.*
import Jugador.*

class Nivel {
	var property enemigos = []
	var property indice = 1
	var property direccion = 1
	
	method generarEnemigos(x, y){
		const fila = 15-y
		if(x.between(2, 10) && fila <= 15){
			const enemigo = new Enemigo(position = game.at(x, fila), image = "assets/enemigo.png", vida = 1)
			enemigos.add(enemigo)	

			game.addVisual(enemigo)
			console.println(self.enemigos().size())
			self.generarEnemigos(x+1, y)	
		}else if(x == 11  && fila <= 15){
			self.generarEnemigos(2, y-1)
		}
	}
	
	method empezar(filas, velocidadMovimiento, velocidadDisparo){
		self.generarEnemigos(2, filas)
		
		game.onTick(velocidadMovimiento, 'moverEnemigos', { 
			self.moverEnemigos()
		})
		
		game.onTick(velocidadDisparo, 'dispararEnemigos', { 
			self.disparoEnemigo()
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
	
	method disparoEnemigo(){
		const enemigosVivos = enemigos.filter{enemigo => enemigo.vida()>0}
		const filaDeAbajo = enemigosVivos.min({enemigo => enemigo.position().y()}).position().y() //Obtengo el enemigo cuya posicion en "y" es la mas baja y luego obtengo el valor de esta
		const enemigosPosibles = enemigosVivos.filter{enemigo => enemigo.position().y() == filaDeAbajo}
		const enemigo = enemigosPosibles.anyOne()
		enemigo.disparar()
	}
	
	
}
