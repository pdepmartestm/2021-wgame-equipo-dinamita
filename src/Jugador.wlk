import wollok.game.*
import Disparos.*

class Jugador{
	var property position
	var property image
	var property vida
	
	method position() = position
	
	method cambiarPosicion(x, y){
		position = game.at(x, y)
	}
	
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
	
	var property disparo = new Disparo(
		position = game.at(6, 0),
		image = 'assets/disparo.png',
		speed = 200	
	)
	var disparando = false
	
	method disparar(){
		console.println(disparo.position())
		const userPosition = position
		if(!disparando){
			disparando = !disparando
			disparo.disparar(userPosition.x(), userPosition.y()+1)
			
			game.onTick(disparo.speed(), 'movimiento', {
				disparo.moverse(1)
			})
		}
			
		game.whenCollideDo(disparo, { enemigo =>
			disparo.disparar(20, 20)
			enemigo.golpe()
			game.removeTickEvent("movimiento")
			disparando = !disparando	
		})
	}
}

class Enemigo inherits Jugador{
	
	/*var property disparo = new Disparo(
		position = game.at(6, 0),
		image = 'assets/disparo.png',
		speed = 200	
	)*/
	method disparar(){
		const userPosition = position
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
