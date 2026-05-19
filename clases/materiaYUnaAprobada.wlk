import carreraYCurso.*
import estudiante.*
import inscripcion.*

class Materia {
    const property cupo
    const requisitos = []
    const estudiantesInscriptos = []
    const estudiantesEnEspera = []

    method requisitos() {
        return requisitos
    }

    method materia() {
        return self
    }

    method superaElCupo() = estudiantesInscriptos.size() >= self.cupo()
    
    method agregar(estudiante) {
        if (self.superaElCupo()) {
            estudiantesEnEspera.add(estudiante)
        } else {
            estudiantesInscriptos.add(estudiante)
        }
    }

    method remover(estudiante) {
        if (self.estaElEstudianteEn(estudiantesInscriptos, estudiante)) {
            estudiantesInscriptos.remove(estudiante) 
        } else if (self.estaElEstudianteEn(estudiantesEnEspera, estudiante))
            estudiantesEnEspera.remove(estudiante)
    }

    method estaElEstudianteEn(lista, estudiante) = lista.contains(estudiante)

    method darDeBaja(estudiante) {
        self.remover(estudiante)
        self.puedeAgregarPrimerEstudianteEnEspera()
    }
    
    method puedeAgregarPrimerEstudianteEnEspera() = if(self.hayEstudiantesEnEspera()) { self.agregarPrimerEstudianteEnEspera() }

    method hayEstudiantesEnEspera() = !estudiantesEnEspera.isEmpty()

    method agregarPrimerEstudianteEnEspera() {
        const primerEstudianteEnEspera = estudiantesEnEspera.first()
        self.remover(primerEstudianteEnEspera)
        self.agregar(primerEstudianteEnEspera)
    }

    method estudiantesInscriptos() {
        return estudiantesInscriptos
    }

    method estudiantesEnEspera() {
        return estudiantesEnEspera
    }

    method inscribirA(estudiante) {
        if (!estudiante.puedeInscribirseEn(self)) {
            self.error("Ya esta inscripto o no se cumplen los requisitos")
        }
        self.agregar(estudiante)
    }
}

class MateriaAprobada {
    const property materia  
    const nota  

    method nota() {
      return nota
    }
}