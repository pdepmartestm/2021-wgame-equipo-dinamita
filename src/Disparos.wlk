import wollok.game.*

class Disparo {
	
	const speed = 200
	const image = 'assets/disparo.png'
	var property position = game.at(0, 0)
	
	method image() = image	
	method speed() = speed
	
	method disparar(x, y){
		position = game.at(x, y)
	}
	method golpe(){}
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

