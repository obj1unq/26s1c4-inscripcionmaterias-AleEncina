import extras.*
import materia.*

class Estudiante{
    const property cursoActual
    const carrerasElegidas = []
    const materiasAprobadas = []

    method aprobar(_materia, _nota){    // -> juan.aprobar(objetos1, 7)
        if(self.aprobo(_materia)){
            self.error("Ya esta aprobada")
        }
        materiasAprobadas.add( new MateriaAprobada (materia=_materia, nota=_nota))
    }

    method aprobo(unaMateria) = materiasAprobadas.map( { materiaAprobada => materiaAprobada.materia() } ).contains(unaMateria) //map y contains

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

    method perteneceAUnaCarreraElegida(unaMateria) = self.todasLasMateriasDeLasCarrerasElegidas().any( { materiaObligatoria => materiaObligatoria.materia() == unaMateria } )

    method estaInscriptoEn(materia) = materia.estudiantesInscriptos().contains(self) || self.estaEnEsperaEn(materia)

    method estaEnEsperaEn(materia) = materia.estudiantesEnEspera().contains(self)

    method cumpleRequisitosParaInscribirse(materia) = materia.requisitos().all( { requisito => self.aprobo(requisito) } )

    method inscribirEn(materia) {
        materia.inscribirA(self)
    }

    method materiasInscriptas() = self.todasLasMateriasDeLasCarrerasElegidas().filter( { materia => self.estaInscriptoEn(materia) } )

    method materiasEnEspera() = self.todasLasMateriasDeLasCarrerasElegidas().filter( { materia => self.estaEnEsperaEn(materia) } )

    method materiasAInsribir(carrera) = self.todasLasMateriasDe(carrera).filter( { materia => self.puedeInscribirseEn(materia) } )
}


