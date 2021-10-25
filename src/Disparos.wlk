import wollok.game.*

class Disparo {
	
	//VELOCIDAD PELOTA
	const speed = 200
	const image = 'assets/disparo.png'
	var property position = game.at(0, 0)
	
	method image() = image	
	method speed() = speed
	
	method moverse(direccion){	
		if(position.y() < 16) {
			self.position(position.up( direccion ))
		}
	}
	
	method disparar(x, y){
		position = game.at(x, y)
	}
}
