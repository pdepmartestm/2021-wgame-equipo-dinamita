import wollok.game.*

object disparo {
	
	//VELOCIDAD PELOTA
	const speed = 100
	const image = 'assets/disparo.png'
	var position = game.at(0, 0)
	
	method image() = image	
	method speed() = speed
	
	method moverse(direccion){		
		if(position.y() < 16) {
			position.up(direccion) 
		}
	}
	
	method disparar(x, y){
		position = game.at(x, y)
	}
	
	//MOVIMIENTO EN Y
	method moverseEnY(){
		//if([0, 24].contains(position.y())) direccionY *= -1
	}
	
	// Si se sale de los límites nos vamos
	method gameOver(){
		//if ([-1, 25].contains(position.x())) gameManager.mostrarMenu()
  	}	
}