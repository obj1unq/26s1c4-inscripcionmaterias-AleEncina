class EstrategiaOrdenDeLlegada {
    method agregarALaListaDeEspera(estudiante, materia) {
        materia.estudiantesEnEspera().add(estudiante)
    }
}

class EstrategiaElitista {
    method agregarALaListaDeEspera(estudiante, materia) {
        materia.estudiantesEnEspera().add(estudiante)
        materia.estudiantesEnEspera().sortBy({ unEstudiante => unEstudiante.promedioMateriasAprobadas() }).reverse()
    }
}

class EstrategiaGradoDeAvance {
    method agregarALaListaDeEspera(estudiante, materia) {
        materia.estudiantesEnEspera().add(estudiante)
        materia.estudiantesEnEspera().sortBy({ unEstudiante => unEstudiante.cantMateriasAprobadas() }).reverse()
    }
}

class RequisitoCorrelativas {
    const property materias 

    method cumple(alumno) = materias.all({ unaMateria => alumno.aprobo(unaMateria) })   //Polimorfica con los otros requisitos
}

class RequisitoCreditos {
    const property creditosNecesarios // Número de créditos

    method cumple(alumno) = alumno.creditosObtenidos() >= creditosNecesarios         //Polimorfica con los otros requisitos
}

class RequisitoAnio {
    const property anioRequerido
    const property carrera  //La materia con este requisito no debe estar en la lista materias de la carrera que pertenece, sino el codigo falla. 
    method cumple(alumno) = self.materiasDelAnioRequerida().all({ materia=> alumno.aprobo(materia) })    //Polimorfica con los otros requisitos

    method materiasDelAnioRequerida() = carrera.materiasDeAnio(anioRequerido)
}
