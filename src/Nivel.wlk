import wollok.game.*
import Jugador.*

class Nivel {
	const enemigos = []
	
	method generarEnemigos(x, y){
		const fila = 15-y
		console.println("x: " + x + ", y: " + fila)
		if(x.between(0, 15) && fila <= 15){
			const enemigo = new Enemigo(position = game.at(x, fila), image = "assets/enemigo.png", vida = 1)
			enemigos.add(enemigo)	
			game.addVisual(enemigo)
			console.println(fila)
			self.generarEnemigos(x+1, y)	
		}else if(x == 16  && fila <= 15){
			self.generarEnemigos(0, y-1)
		}
	}
	
	method empezar(filas){
		//console.println("filas: " + filas)
		self.generarEnemigos(0, filas)
		
	}
	
	
	
}
