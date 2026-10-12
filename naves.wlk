class Nave {
	var property velocidad = 0

	method recibirAmenaza() {}

	method propulsar() {
		velocidad = if (velocidad + 20000 > 300000) 300000 else velocidad + 20000
	}

	method prepararParaViajar() {
		velocidad = if (velocidad + 15000 > 300000) 300000 else velocidad + 15000
	}

	method encontrarEnemigo() {
		self.recibirAmenaza()
		self.propulsar()
	}
}

class NaveDeCarga inherits Nave {

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveDeCargaRadiactiva inherits NaveDeCarga {
	var property sellada = false

	override method recibirAmenaza() {
		sellada = true
		velocidad = 0
	}

	override method prepararParaViajar() {
		sellada = true
		super()
	}

}

class NaveDePasajeros inherits Nave {

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave {
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

	override method prepararParaViajar() {
		modo.prepararParaViajar(self)
		super()
	}
}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method prepararParaViajar(nave) {
		nave.emitirMensaje("Saliendo en misión")
		nave.modo(ataque)  
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method prepararParaViajar(nave) {
		nave.emitirMensaje("Volviendo a la base")
	}

}
