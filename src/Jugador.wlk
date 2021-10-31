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
	
	method disparar(){
		const userPosition = position
		if(!disparoUsuario.disparando()){
			disparoUsuario.disparando(!disparoUsuario.disparando())
			disparoUsuario.disparar(userPosition.x(), userPosition.y()+1)
			
			game.onTick(disparoUsuario.speed(), 'disparoUsuario', {
				disparoUsuario.moverse()
			})
		}
			
		game.whenCollideDo(disparoUsuario, { enemigo =>
			disparoUsuario.disparar(20, 20)
			enemigo.golpe()
			game.removeTickEvent("disparoUsuario")
			disparoUsuario.disparando(!disparoUsuario.disparando())
		})
	}
}

class Enemigo inherits Jugador{
	
	method disparar(){
		const enemyPosition = position
		if(!disparoEnemigo.disparando()){
			disparoEnemigo.disparando(!disparoEnemigo.disparando())
			disparoEnemigo.disparar(enemyPosition.x(), enemyPosition.y()-1)
			
			game.onTick(disparoEnemigo.speed(), 'disparoEnemigo', {
				disparoEnemigo.moverse()
			})
		}
			
		game.whenCollideDo(disparoEnemigo, { usuario =>
			disparoEnemigo.disparar(20, 20)
			usuario.golpe()
			game.removeTickEvent("disparoEnemigo")
			disparoEnemigo.disparando(!disparoEnemigo.disparando())
		})
	}
}
