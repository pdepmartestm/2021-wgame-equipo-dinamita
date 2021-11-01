import wollok.game.*

class Disparo {
	
	const speed = 200
	const image = 'assets/disparo.png'
	var property position = game.at(30, 30)
	
	method image() = image	
	method speed() = speed
	
	method disparar(x, y){
		position = game.at(x, y)
	}
	
	method desaparecer(){
		position = game.at(30, 30)
	}
	
	method colision(){
		try{
			game.removeTickEvent("disparoUsuario")
			game.removeTickEvent("disparoEnemigo")
		} catch e : Exception{
			
		}
		disparoUsuario.disparando(false)
		disparoEnemigo.disparando(false)
		disparoUsuario.desaparecer()
		disparoEnemigo.desaparecer()
		
	}
}

object disparoUsuario inherits Disparo{
	var property disparando = false
	
	method moverse(){	
		if(position.y() < 16) {
			self.position(position.up( 1 ))
		}else{
			disparando = false
			game.removeTickEvent("disparoUsuario")
		}
	}
}

object disparoEnemigo inherits Disparo{
	var property disparando = false
	
	method moverse(){	
		if(position.y() >= 0) {
			self.position(position.down( 1 ))
		}else{
			disparando = false
			game.removeTickEvent("disparoEnemigo")
		}
	}
}

