import extras.*
import materia.*

class Estudiante{
    const property creditosObtenidos
    const carrerasElegidas = []
    const materiasAprobadas = [] 

    method aprobar(_materia, _nota){    // -> juan.aprobar(objetos1, 7)
        if(self.aprobo(_materia)){
            self.error("Ya esta aprobada")
        }
        materiasAprobadas.add( new MateriaAprobada (materia=_materia, nota=_nota))
    }

    method aprobo(unaMateria) = self.materiasDeLasQueTengoAprobada().contains(unaMateria) //map y contains

    method materiasDeLasQueTengoAprobada() = materiasAprobadas.map( { materiaAprobada => materiaAprobada.materia() } )

    method elegirCarrera(carrera) {
        carrerasElegidas.add(carrera)
    }
    method cantMateriasAprobadas() = materiasAprobadas.size()

    method promedioMateriasAprobadas() = if(self.noAproboNingunaMateria()) { 0 } else { self.notasDeMisMatareriasAprobadas().average() }
    
    method notasDeMisMatareriasAprobadas() = materiasAprobadas.map( { materiaAprobada => materiaAprobada.nota() } )

    method noAproboNingunaMateria() = materiasAprobadas.isEmpty()

    method todasLasMateriasDe(carrera) = carrera.materiasObligatorias()

    method todasLasMateriasDeLasCarrerasElegidas() = carrerasElegidas.flatMap( { carrera => self.todasLasMateriasDe(carrera) } )

    method puedeInscribirseEn(materia) = self.perteneceAUnaCarreraElegida(materia) && !self.aprobo(materia) 
    && !self.estaInscriptoEn(materia) && self.cumpleRequisitosParaInscribirse(materia)

    method perteneceAUnaCarreraElegida(unaMateria) = self.todasLasMateriasDeLasCarrerasElegidas().contains(unaMateria)

    method estaInscriptoEn(materia) = materia.estudiantesInscriptos().contains(self) || self.estaEnEsperaEn(materia)

    method estaEnEsperaEn(materia) = materia.estudiantesEnEspera().contains(self)

    method cumpleRequisitosParaInscribirse(materia) = materia.requisito().cumple(self)

    method requisitoDe(materia) = materia.requisito().elemento()

    method inscribirEn(materia) {
        materia.inscribirA(self)
    }

    method materiasInscriptas() {
        return self.todasLasMateriasDeLasCarrerasElegidas().filter( { materia => self.estaInscriptoEn(materia) } )
    }

    method materiasEnEspera() {
        return self.todasLasMateriasDeLasCarrerasElegidas().filter( { materia => self.estaEnEsperaEn(materia) } )
    }

    method materiasAInsribir(carrera) {
        return self.todasLasMateriasDe(carrera).filter( { materia => self.puedeInscribirseEn(materia) } )   
    }
}


