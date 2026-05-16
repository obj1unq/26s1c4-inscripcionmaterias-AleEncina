import carreraYCurso.*
import materiaYUnaAprobada.*
import inscripcion.*

class Estudiante{
    const property nombre
    const property cursoActual
    const carrerasElegidas = []
    const materiasAprobadas = []

    method aprobar(_materia, _nota){    // -> juan.aprobar(objetos1, 7)
        if(self.aprobo(_materia)){
            self.error("Ya esta aprobada")
        }
        materiasAprobadas.add( new MateriaAprobada (materia=_materia, nota=_nota))
    }

    method aprobo(materia) = materiasAprobadas.any( { materiaAprobada => materia.esLaMateria(materiaAprobada) } )

    method elegirCarrera(carrera) {
        carrerasElegidas.add(carrera)
    }

    method cantMateriasAprobadas() = materiasAprobadas.size()

    method promedioMateriasAprobadas() = if(self.noAproboNingunaMateria()) { 0 } else { materiasAprobadas.map( { materiaAprobada => materiaAprobada.nota() } ).average() }
    
    method noAproboNingunaMateria() = materiasAprobadas.isEmpty()

    method todasLasMateriasDe(carrera) = carrera.materiasObligatorias()

    method todasLasMateriasDeLasCarrerasElegidas() = carrerasElegidas.flatMap( { carrera => self.todasLasMateriasDe(carrera) } )

    method puedeInscribirseEn(materia) = self.perteneceAUnaCarreraElegida(materia) && !self.aprobo(materia) 
    && !self.estaInscriptoEn(materia) && self.cumpleRequisitosParaInscribirse(materia)

    method perteneceAUnaCarreraElegida(materia) = self.todasLasMateriasDeLasCarrerasElegidas().any( { materiaObligatoria => materia.esLaMateria(materiaObligatoria) } )

    method estaInscriptoEn(materia) = materia.estudiantesInscriptos().contains(self.nombre()) || self.estaEnEsperaEn(materia)

    method estaEnEsperaEn(materia) = materia.estudiantesEnEspera().contains(self.nombre())

    method cumpleRequisitosParaInscribirse(materia) = materia.requisitos().all( { requisito => materiasAprobadas.contains(requisito) } )

    method inscribir(_materia) {
        const inscripcion = new Inscripcion (estudiante=self, materia=_materia)
        inscripcion.realizarInscripcion()
    }

    method materiasInscriptas() = self.todasLasMateriasDeLasCarrerasElegidas().filter( { materia => self.estaInscriptoEn(materia) } )

    method materiasEnEspera() = self.todasLasMateriasDeLasCarrerasElegidas().filter( { materia => self.estaEnEsperaEn(materia) } )

    method materiasAInsribir(carrera) = self.todasLasMateriasDe(carrera).filter( { materia => self.puedeInscribirseEn(materia) } )
}


