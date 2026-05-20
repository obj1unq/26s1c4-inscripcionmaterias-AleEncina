class Carrera {
    const materiasObligatorias = []

    method materiasObligatorias(){
        return materiasObligatorias
    }
}

class Curso {
    const property nombre
    const property año
}

class MateriaAprobada {
    const property materia  
    const nota  

    method nota() {
      return nota
    }
}

class Requisito {
    const property tipo         //correlativa, cŕedito, anio o nada.
    const valor            //[materia...], numCredito, numAnio o null

    method valor(){
        return valor
    }
}

object universidad {
    const carreras = []

    method carreras() {
        return carreras
    }
}
