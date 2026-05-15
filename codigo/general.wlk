class Materia {
    const property cupo
    const requisitos = []
    const estudiantesInscritos = []
    const listaDeEspera = []

    method requisitos() {
        return requisitos
    }

    method agregarEstudiante(estudiante) {
        estudiantesInscritos.add(estudiante)
    }

    method agregarEstudianteEnEspera(estudiante) {
        listaDeEspera.add(estudiante)
    }

    method nroEstudiantesInscritos() = estudiantesInscritos.size()
    
    method removerEstudiante(estudiante) {
        estudiantesInscritos.remove(estudiante)
    }

    method removerEstudianteDeEspera(estudiante) {
        listaDeEspera.remove(estudiante)
    }

    method hayEstudiantesEnEspera() = !listaDeEspera.isEmpty()

    method agregarPrimerEstudianteEnEspera() {
        const estudianteEnEspera = listaDeEspera.first()
        listaDeEspera.remove(estudianteEnEspera)
        self.agregarEstudiante(estudianteEnEspera)
}
}

class MateriaAprobada {
    const property materia  
    const nota  

    method nota() {
      return nota
    }

    method estaLaMateria(unaMateria) = materia == unaMateria
}


class Inscripcion {
    const property estudiante
    const property materia
    
    method realizarInscripcion() {
        if (!self.puedeRealizarInscripcion()) {
            self.error("Ya esta inscripto o no se cumplen los requisitos")
        }
        estudiante.inscribir(materia)
        self.agregarEstudianteInscrito()
    }

    method puedeRealizarInscripcion() = estudiante.perteneceAUnaCarreraElegida(materia) && !estudiante.aprobo(materia) && !estudiante.estaInscriptoEn(materia) 
    && estudiante.cumpleRequisitosParaInscribirse(materia)
    

    method agregarEstudianteInscrito() {
        if (materia.nroEstudiantesInscritos() < materia.cupo()) {
            materia.agregarEstudiante(estudiante)
        } else {
            materia.agregarEstudianteEnEspera(estudiante)
        }
    }

    method darDeBaja() {
        estudiante.darDeBaja(materia)
        materia.removerEstudiante(estudiante)
        self.puedeAgregarEstudianteEnEspera()
    }

    method puedeAgregarEstudianteEnEspera() {
        if (materia.hayEstudiantesEnEspera()) {
            materia.agregarPrimerEstudianteEnEspera()
        }
    }


}
class CarreraElegida {
    const nombreCarrera
    const materiasObligatorias = []
    const property estudiante

    method nombreCarrera() {
        return nombreCarrera
    }

    method materiasObligatorias(){
        return materiasObligatorias
    }


}


class Carrera {
    const property nombreCarrera
    const materiasObligatorias = []

    method materiasObligatorias(){
        return materiasObligatorias

    }

}

