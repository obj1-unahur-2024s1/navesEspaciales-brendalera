class Nave{
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
}

class NaveBaliza inherits Nave{
	var balizaColor = ""
	method cambiarColorDeBaliza(color){ balizaColor = color }
}

// method desplazarse()      // Metodo abstracto, se implementa en las sub clases que heredan el metodo.
// method detener(){
//  super() 
// }
// El metodo super hace que se siga ejecutando el codigo del objeto o clase que hereda.
// Se puede inicializar las variables en las herencias, determinar un valor inicial por parametros.
// 


class NavePasajeros inherits Nave{
	
} 

class NaveCombate inherits Nave{
}
