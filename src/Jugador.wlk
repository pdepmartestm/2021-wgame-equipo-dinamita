import wollok.game.*
import Disparos.*
import gameManager.*
import enemigosManager.*

class Jugador{
	var property position
	var property image
	var property vida
	const low = 0
	const hight = 12
	
	method position() = position
	
	method cambiarPosicion(x, y){
		position = game.at(x, y)
	}
	
	method disparar(disparo, evento, direccion){
		const userPosition = position
		if(!disparo.disparando()){
			disparo.disparando(!disparo.disparando())
			disparo.disparar(userPosition.x(), userPosition.y() + direccion)
			
			game.onTick(disparo.speed(), evento, {
				disparo.moverse()
			})
		}
	}
	
	method moverse(direccion){
		if (! ( (position.x() == low && direccion < 0) || (position.x() == hight && direccion > 0) ) )
			self.position(position.right( direccion ))
	}
}


object usuario inherits Jugador(
	position = game.at(6, 0),
	image = "assets/nave.png",
	vida = 3
) {	
	method evento() = "disparoUsuario" 
	
	method eliminar(){
		position = game.at(21,21)
	}
	
	method colision(){
		console.println("disparoEnemigo colisiona con el usuario")
		try{
			game.removeTickEvent("disparoEnemigo")
		} catch e : Exception{
			
		}
		disparoEnemigo.desaparecer()
		disparoEnemigo.disparando(false)
		
		//Le resto la vida al jugador
		vida -= 1
		if(vida <= 0) {
			gameManager.lose()
		}
	}
}

class Enemigo inherits Jugador{
	method evento() = "disparoEnemigo" 
	
	method colision(){
		console.println("disparoUsuario colisiona con el enemigo")
		
		//Elimino el disparo del usuario
		try{
			game.removeTickEvent("disparoUsuario")
		} catch e : Exception{
			
		}
		disparoUsuario.desaparecer()
		disparoUsuario.disparando(false)
		
		//Le resto la vida al enemigo
		vida -= 1
		if(vida <= 0) game.removeVisual(self)
		
		//Saco al enemigo
		enemigosManager.borrarEnemigo(self)	
		enemigosManager.validarCantidadEnemigos()
		gameManager.sumarPunto()
	}
	
}
