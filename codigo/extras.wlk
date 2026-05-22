class Carrera {
    const materiasObligatorias = []

    method materiasObligatorias(){
        return materiasObligatorias
    }

    method materiasDeAnio(unAnio) {
        return materiasObligatorias.filter({ materia => materia.anio() == unAnio })
    }
}

class Curso {
    const property año
}

class MateriaAprobada {
    const property materia  
    const nota  

    method nota() {
      return nota
    }
}

object universidad {
    const carreras = []

    method carreras() {
        return carreras
    }
}
