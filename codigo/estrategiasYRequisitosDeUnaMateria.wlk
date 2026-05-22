class EstrategiaOrdenDeLlegada {
    method agregarALaListaDeEspera(estudiante, materia) {
        materia.estudiantesEnEspera().add(estudiante)
    }
}

class EstrategiaElitista {
    method agregarALaListaDeEspera(estudiante, materia) {
        materia.estudiantesEnEspera().add(estudiante)
        self.reordenarEstudiantesEnEsperaDe(materia)
    }

    method reordenarEstudiantesEnEsperaDe(materia) = materia.estudiantesEnEspera().sortedBy({ est1, est2 => est1.promedioMateriasAprobadas() > est2.promedioMateriasAprobadas() })
}

class EstrategiaGradoDeAvance {
    method agregarALaListaDeEspera(estudiante, materia) {
        materia.estudiantesEnEspera().add(estudiante)
        self.reordenarEstudiantesEnEsperaDe(materia).reverse()
    }

    method reordenarEstudiantesEnEsperaDe(materia) = materia.estudiantesEnEspera().sortedBy({ est1, est2 => est1.cantMateriasAprobadas() > est2.cantMateriasAprobadas() })
//            unEstudiante => unEstudiante.cantMateriasAprobadas() })
}


class RequisitoAnio {     //Este requisito debe tener siempre una referencia para agregar la carrera en el initialize, evitando el bucle de datos en los objetos creados.
    const property anioRequerido
    var property carrera = null  
    method cumple(alumno) = self.materiasDelAnioRequerida().all({ materia=> alumno.aprobo(materia) })    //Polimorfica con los otros requisitos

    method materiasDelAnioRequerida() = carrera.materiasDeAnio(anioRequerido)
}

class RequisitoCorrelativas {
    const property materias 

    method cumple(alumno) = materias.all({ unaMateria => alumno.aprobo(unaMateria) })   //Polimorfica con los otros requisitos
}

class RequisitoCreditos {
    const property creditosNecesarios // Número de créditos

    method cumple(alumno) = alumno.creditosObtenidos() >= creditosNecesarios         //Polimorfica con los otros requisitos
}

