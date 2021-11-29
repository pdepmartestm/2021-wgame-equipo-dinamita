import wollok.game.*
import Jugador.*
import Score.*
import Disparos.*
import enemigosManager.*

class Nivel {
	var property velocidadEnemigos 
	var property velocidadDisparos
	var property velocidadAvance
	
	method empezar(){
		enemigosManager.generarEnemigos(2, 1)
		
		game.onTick(velocidadEnemigos, 'moverEnemigos', { 
			enemigosManager.moverEnemigos()
		})
		
		game.onTick(velocidadDisparos, 'dispararEnemigos', { 
			enemigosManager.dispararEnemigo()
		})
		
		game.onTick(velocidadAvance, "avanzarEnemigos",{
			enemigosManager.avanzarEnemigos()
		})
		
	}
}
