import wollok.game.*
import Jugador.*

class Nivel {
	var property enemigos = []
	var property indice = 1
	var property direccion = 1
	method enemigos() = enemigos
	
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
		//console.println(enemigos.size())
		/*game.onTick(1000, 'moverEnemigos', { 
			self.moverEnemigos(1000)
		})*/
	}
	
	method empezar(filas, velocidadMovimiento, velocidadDisparo){
		self.generarEnemigos(2, filas)
		
		game.onTick(velocidadMovimiento, 'moverEnemigos', { 
			self.moverEnemigos(velocidadMovimiento)
		})
		
		game.onTick(velocidadDisparo, 'dispararEnemigos', { 
			self.moverEnemigos(velocidadDisparo)
		})
		
	}
	
	method moverEnemigos(velocidad){
		enemigos.forEach({enemigo =>
			enemigo.position(enemigo.position().right( direccion ))
		})
		if(enemigos.any({e => e.position().x() == 12}) || enemigos.any({e => e.position().x() == 0})){
			direccion *= -1
		}
	}
	
	
}