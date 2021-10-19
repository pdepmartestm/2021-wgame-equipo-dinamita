import wollok.game.*
import disparo.*

class Jugador{
	var property position
	var property image
	var property vida
	
	method moverse(direccion){
		if (! ( (position.x() == 0 && direccion < 0) || (position.x() == 12 && direccion > 0) ) )
			self.position(position.right( direccion ))
	}
	
	method golpe(){
		vida -= vida
		if(vida <= 0) game.removeVisual(self)
	}
}


object usuario inherits Jugador(
	position = game.at(6, 0),
	image = "assets/nave.png",
	vida = 3
) {	
	var disparando = false
	
	method disparar(){
		disparando = true
		const userPosition = position
		if(!disparando){
			disparo.disparar(userPosition.x(), userPosition.y()+1)
			
			game.onTick(disparo.speed(), 'movimiento', {
				disparo.moverse(1)
			})
		}
			
		game.whenCollideDo(disparo, { enemigo =>
			enemigo.golpe()
			game.removeTickEvent("movimiento")
		})
	}
}

class Enemigo inherits Jugador{
	
	method disparar(){
		//const userPosition = position
		//const disparo = new Disparo(position = game.at(userPosition.x(), userPosition.y()-1));
		/*game.addVisual(disparo)
		game.onTick(disparo.speed(), 'movimiento', {
			disparo.moverse(-1)
		})
		game.whenCollideDo(disparo, { Jugador =>
			Jugador.golpe()
		})*/
	}
}
