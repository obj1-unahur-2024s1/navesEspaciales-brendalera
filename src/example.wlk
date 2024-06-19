class Nave{
	var combustible
	var velocidad
	var direccion
	method acelerar(cuanto){
		velocidad = (velocidad + cuanto).min(100000)
	}
	method desacelerar(cuanto){
		velocidad = (velocidad - cuanto).max(0)
	}
	method irHaciaElSol(){ direccion = 10 }
	method escaparDelSol(){ direccion = -10 }
	method ponerseParaleloAlSol(){ direccion = 0 }
	method acercarseUnPocoAlSol(){
		direccion = (direccion + 1).min(10)
	}
	method alejarseUnPocoDelSol(){
		direccion = (direccion - 1).max(-10)
	}
	method cargarCombustible(cant){
		combustible += cant
	}
	method descargarCombustible(cant){
		combustible = (combustible - cant).max(0)
	}
	method prepararViaje(){
		self.cargarCombustible(30000)
		self.acelerar(5000)
	}
	method estaTranquila() = combustible >= 4000 and velocidad < 12000 and self.adicionalTranquilidad()
	method adicionalTranquilidad()
	method recibirAmenaza(){
		self.escapar()
		self.avisar()
	}
	method avisar()
	method escapar()
	method estaRelajado() = self.estaTranquila() and self.pocaActividad()
	method pocaActividad()
}

class NaveBaliza inherits Nave{
	var balizaColor = "azul"
	var cambioColor = false
	method cambiarColorDeBaliza(color){
		balizaColor = color
		cambioColor = true
	}
	method baliza() = balizaColor
	override method prepararViaje(){
		super()
		self.cambiarColorDeBaliza("verde")
		self.ponerseParaleloAlSol()
	}
	override method adicionalTranquilidad() = balizaColor != "rojo"
	override method	escapar(){
		self.irHaciaElSol()
	}
	override method avisar(){
		self.cambiarColorDeBaliza("rojo")
	}
	override method pocaActividad() = not cambioColor
}

// method desplazarse()      // Metodo abstracto, se implementa en las sub clases que heredan el metodo.
// method detener(){
//  super() 
// }
// El metodo super hace que se siga ejecutando el codigo del objeto o clase que hereda.
// Se puede inicializar las variables en las herencias, determinar un valor inicial por parametros.

class NavePasajeros inherits Nave{
	const property pasajeros  = 0
	var property alimentos = 0
	var property bebidas = 0
	var comidaServida = 0
	method cargarRacionComida(cant){
		alimentos += cant
	}
	method cargarRacionBebida(cant){
		bebidas += cant
	}
	method descargarRacionComida(cant){
		alimentos = (alimentos - cant).max(0)
	}
	method descargarRacionBebida(cant){
		bebidas = (bebidas - cant).max(0)
	}
	method servirComida(cant){
		comidaServida += cant.min(alimentos)
		self.descargarRacionComida(cant)
	}
	override method prepararViaje(){
		super()
		self.cargarRacionComida(pasajeros * 4)
		self.cargarRacionBebida(pasajeros * 6)
		self.acercarseUnPocoAlSol()
	}
	override method adicionalTranquilidad() = true
	override method	escapar(){
		self.acelerar(velocidad * 2)	
	}
	override method avisar(){
		self.servirComida(pasajeros)
		self.descargarRacionBebida(pasajeros * 2)
	}
	override method pocaActividad() = comidaServida < 50 
} 

class NaveHospital inherits NavePasajeros{
	var property quirofanosPreparados = false
	method prepararQuirofanos(){
		quirofanosPreparados = true
	}
	override method adicionalTranquilidad() = not self.quirofanosPreparados()  
	override method recibirAmenaza(){
		super()
		self.prepararQuirofanos()
	}
}

class NaveCombate inherits Nave{
	var visible
	var property misilesDesplegados
	const mensajes = []
	method ponerseVisible(){
		visible = true
	}
	method ponerseInvisible(){
		visible = false
	}
	method estaVisible() = visible 
	method desplegarMisiles(){
		misilesDesplegados = true 
	}
	method replegarMisiles(){
		misilesDesplegados = false
	}
	method emitirMensaje(mensaje){
		mensajes.add(mensaje)
	}
	method mensajesEmitidos() = mensajes
	method primerMensajeEmitido() = mensajes.first()
	method ultimoMensajeEmitido() = mensajes.last()
	method esEscueta() = not mensajes.any({mensaje => mensaje.size() > 30})
	method emitioMensaje(mensaje) = mensajes.constain(mensaje)
	override method prepararViaje(){
		super()
		self.ponerseVisible()
		self.desplegarMisiles()
		self.acelerar(15000)
		self.emitirMensaje("saliendo en mision")
	}
	override method adicionalTranquilidad() = not self.misilesDesplegados()  
	override method	escapar(){
		self.acercarseUnPocoAlSol()
		self.acercarseUnPocoAlSol()
	}
	override method avisar(){
		self.emitirMensaje("amenaza recibida")
	}
	override method pocaActividad() = self.esEscueta()
}

class NaveCombateSigilosa inherits NaveCombate{
	override method adicionalTranquilidad() = super() and not self.estaVisible()
	override method recibirAmenaza(){
		super()
		self.desplegarMisiles()
		self.ponerseInvisible()
	}
} 

/*
class Boliche{
	const capacidad  = 1000
	var cantGente
	method entrar(cant){
		 //self.error("no hay lugar")
		if(self.lugarDisponible() < cant)
		   throw new Exception(message = "no hay lugar")
		cantGente += cant 
	}
	method lugarDisponible() = capacidad - cantGente
}
*/
// para testear exception =  assert.throwsExceptionWithMessage("no hay lugar", {boliche.entrar(2})

