class Carrera {
    const materiasObligatorias = []

    method materiasObligatorias(){
        return materiasObligatorias
    }

    method materiasDeAnio(unAnio) {
    return materiasObligatorias.filter({ m => m.anio() == unAnio })
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

class RequisitoCorrelativas {
    const property materias 

    method cumple(alumno) = materias.all({ unaMateria => alumno.aprobo(unaMateria) })              //Polimorfica con los otros requisitos
}

class RequisitoCreditos {
    const property creditosNecesarios // Número de créditos

    method cumple(alumno) = alumno.creditosObtenidos() >= creditosNecesarios                       //Polimorfica con los otros requisitos
}

class RequisitoAnio {
    const property anioRequerido
    //const property carrera // Objeto que tiene la lista de todas las materias

    method cumple(alumno) = self.materiasDeUnAnio(Carrera, alumno).all({ m => alumno.aprobo(m) })

    method materiasDeUnAnio(carrera, alumno) {
      const carreraDelAlumno = alumno.carrerasElegidas().first()
      return carreraDelAlumno.materiasObligatorias().filter({ m => m.anio() == anioRequerido })
    }
}



object universidad {
    const carreras = []

    method carreras() {
        return carreras
    }
}
