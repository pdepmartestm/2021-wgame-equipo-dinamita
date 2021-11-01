import wollok.game.*
import Disparos.*
import gameManager.*

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
}


object usuario inherits Jugador(
	position = game.at(6, 0),
	image = "assets/nave.png",
	vida = 3
) {	
	method colision(){
		console.println("disparoEnemigo colisiona con el usuario")
		try{
			game.removeTickEvent("disparoEnemigo")
		} catch e : Exception{
			
		}
		disparoEnemigo.disparar(20, 20)
		disparoEnemigo.disparando(false)
		
		//Le resto la vida al jugador
		vida -= 1
		if(vida <= 0) {
			gameManager.gameOver()
		}
	}
	
	method disparar(){
		const userPosition = position
		if(!disparoUsuario.disparando()){
			disparoUsuario.disparando(!disparoUsuario.disparando())
			disparoUsuario.disparar(userPosition.x(), userPosition.y()+1)
			
			game.onTick(disparoUsuario.speed(), 'disparoUsuario', {
				disparoUsuario.moverse()
			})
		}
			
		game.whenCollideDo(disparoUsuario, { elemento =>
			elemento.colision()
		})
	}
}

class Enemigo inherits Jugador{
	
	method colision(){
		console.println("disparoUsuario colisiona con el enemigo")
		
		//Elimino el disparo del usuario
		try{
			game.removeTickEvent("disparoUsuario")
		} catch e : Exception{
			
		}
		disparoUsuario.disparar(20, 20)
		disparoUsuario.disparando(false)
		
		//Añadir puntos
		
		//Le resto la vida al enemigo
		vida -= 1
		if(vida <= 0) game.removeVisual(self)
		
		gameManager.sumarPunto()
		gameManager.validarCantidadEnemigos()
	}
	
	method disparar(){
		const enemyPosition = position
		if(!disparoEnemigo.disparando()){
			disparoEnemigo.disparando(!disparoEnemigo.disparando())
			disparoEnemigo.disparar(enemyPosition.x(), enemyPosition.y()-1)
			
			game.onTick(disparoEnemigo.speed(), 'disparoEnemigo', {
				disparoEnemigo.moverse()
			})
		}
			
		game.whenCollideDo(disparoEnemigo, { elemento =>
			elemento.colision()
		})
	}
}
