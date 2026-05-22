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

    method reordenarEstudiantesEnEsperaDe(materia) =  materia.estudiantesEnEspera().sortBy({ unEstudiante => unEstudiante.promedioMateriasAprobadas() })

    method aplicarReverseSiEsPosible(materia){
        if(!self.esLaListaVacia(materia)){
            self.reordenarEstudiantesEnEsperaDe(materia).reverse()
        }
    }

    method esLaListaVacia(materia) = self.reordenarEstudiantesEnEsperaDe(materia).isEmpty()


}

class EstrategiaGradoDeAvance {
    method agregarALaListaDeEspera(estudiante, materia) {
        materia.estudiantesEnEspera().add(estudiante)
        self.reordenarEstudiantesEnEsperaDe(materia).reverse()
    }

    method reordenarEstudiantesEnEsperaDe(materia) =  materia.estudiantesEnEspera().sortBy({ unEstudiante => unEstudiante.cantMateriasAprobadas() })

    method aplicarReverseSiEsPosible(materia){
        if(!self.esLaListaVacia(materia)){
            self.reordenarEstudiantesEnEsperaDe(materia).reverse()
        }
    }

    method esLaListaVacia(materia) = self.reordenarEstudiantesEnEsperaDe(materia).isEmpty()
}


class RequisitoAnio {
    const property anioRequerido
    const property carrera  //La materia con este requisito no debe estar en la lista materias de la carrera que pertenece, sino el codigo falla. 
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

