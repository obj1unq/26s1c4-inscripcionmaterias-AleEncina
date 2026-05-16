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

    method esLaMateria(unaMateria) = self == unaMateria

    method superaElCupo() = estudiantesInscriptos.size() > self.cupo()
    
    method agregarEn(lista, estudiante) {
        lista.add(estudiante.nombre())
    }

    method removerEn(lista, estudiante) {
        if (self.estaElEstudianteEn(lista, estudiante)) {
            lista.remove(estudiante.nombre())
        }
        //self.error("El estudiante no esta registrado en esta lista")
    }

    method estaElEstudianteEn(lista, estudiante) = lista.contains(estudiante.nombre())

    method darDeBaja(estudiante) {
        self.quitarloDelRegistro(estudiante)
        self.puedeAgregarPrimerEstudianteEnEspera()
    }

    method quitarloDelRegistro(estudiante) {
        self.removerEn(estudiantesInscriptos, estudiante)
        self.removerEn(estudiantesEnEspera, estudiante)
    }
    
    method puedeAgregarPrimerEstudianteEnEspera() = if(self.hayEstudiantesEnEspera()) { self.agregarPrimerEstudianteEnEspera() }

    method hayEstudiantesEnEspera() = !estudiantesEnEspera.isEmpty()

    method agregarPrimerEstudianteEnEspera() {
        const primerEstudianteEnEspera = estudiantesEnEspera.first()
        self.removerEn(estudiantesEnEspera, primerEstudianteEnEspera)
        self.agregarEn(estudiantesInscriptos, primerEstudianteEnEspera)
    }
}

class MateriaAprobada {
    const property materia  
    const nota  

    method nota() {
      return nota
    }
}