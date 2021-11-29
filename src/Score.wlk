import wollok.game.*

class Score {
	var property position
	var property image	

	method position() = position
	method position(newPosition) { position = newPosition } 
	method changeScoreImage(newScore) {
		image = newScore + '.png'
	}
}

const scoreNumberUnidades = new Score(
	position = game.at(2, 14),
	image= 'assets/' + 0.toString() + '.png'
)

const scoreNumberDecenas = new Score(
	position = game.at(1, 14),
	image= 'assets/' + 0.toString() + '.png'
)

const scoreNumberCentenas = new Score(
	position = game.at(0, 14),
	image= 'assets/' + 0.toString() + '.png'
)