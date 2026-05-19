import carreraYCurso.*
import materiaYUnaAprobada.*
import estudiante.*

class Inscripcion {
    const property estudiante
    const property materia

    method realizarInscripcion() {
        if (!estudiante.puedeInscribirseEn(materia)) {
            self.error("Ya esta inscripto o no se cumplen los requisitos")
        }
        materia.agregar(estudiante)
    }

}   
