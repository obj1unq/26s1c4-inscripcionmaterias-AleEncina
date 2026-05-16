import general.*
class Estudiante{
    const carrerasElegidas = []
    const materiasAprobadas = []
    const materiasInscriptas = []

    method aprobar(_materia, _nota){    // -> juan.aprobar(objetos1, 7)
        if(self.aprobo(_materia)){
            self.error("Ya esta aprobada")
        }
        materiasAprobadas.add( new MateriaAprobada (materia=_materia, nota=_nota))
    }

    method aprobo(materia) = materiasAprobadas.any( { materiaAprobada => materiaAprobada.estaLaMateria(materia) } )

    method cantMateriasAprobadas() = materiasAprobadas.size()

    method promedioMateriasAprobadas() = if(self.noAproboNingunaMateria()) { 0 } else { materiasAprobadas.map( { materiaAprobada => materiaAprobada.nota() } ).average() }
    
    method noAproboNingunaMateria() = materiasAprobadas.isEmpty()

    method todasLasMateriasDeLasCarrerasElegidas() = carrerasElegidas.flatMap( { carreraElegida => carreraElegida.materiasObligatorias() } )

    method inscribir(materia) {
        materiasInscriptas.add(materia)
    }

    method darDeBaja(materia) {
        const inscripcionABajar = materiasInscriptas.find( { inscripcion => inscripcion.estaLaMateria(materia) } )
        if (inscripcionABajar.isEmpty()) {
            self.error("No esta inscripto en esa materia")
        }
        materiasInscriptas.remove(materia)
    }

    method perteneceAUnaCarreraElegida(materia) = self.todasLasMateriasDeLasCarrerasElegidas().any( { materiaObligatoria => materiaObligatoria.estaLaMateria(materia) } )

    method estaInscriptoEn(unaMateria) = materiasInscriptas.any( { materia => materia.estaLaMateria(unaMateria) } )

    method cumpleRequisitosParaInscribirse(materia) = materia.requisitos().all( { requisito => materiasAprobadas.contains(requisito) } )

    method materiasEnEspera() = materiasInscriptas.filter( { materia => materia.estaEnEspera() } )
}

