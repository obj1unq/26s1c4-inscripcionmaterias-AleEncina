class Materia {
    const property rquisitos = []
    const property nombreMateria
    const property cupo

    
}

class MateriaAprobada {
    const property materia  
    const nota  

    method nota() {
      return nota
    }

    method estaLaMateria(unaMateria) = materia == unaMateria
    
}

class Estudiante{
    const property nombreEstudiante
    const carrerasElegidas = []
    const materiasAprobadas = []
    const inscripciones = []

    method aprobar(_materia, _nota){    // -> juan.aprobar(objetos1, 7)
        if(self.aprobo(_materia)){
            self.error("Ya esta aprobada")
        }
        materiasAprobadas.add( new MateriaAprobada (materia=_materia, nota=_nota))
    }

    method aprobo(unaMateria) = materiasAprobadas.any( { materiaAprobada => materiaAprobada.estaLaMateria(unaMateria) } )

    method cantMateriasAprobadas() = materiasAprobadas.size()

    method promedioMateriasAprobadas() = if(self.noAproboNingunaMateria()) { 0 } else { materiasAprobadas.map( { materiaAprobada => materiaAprobada.nota() } ).average() }
    
    method noAproboNingunaMateria() = materiasAprobadas.isEmpty()

    method todasLasMateriasDeLasCarrerasElegidas() = carrerasElegidas.flatMap( { carreraElegida => carreraElegida.materiasObligatorias() } )

    method inscribir(_materia) {
        inscripciones.add( new Inscripcion (materia=_materia, estudiante=nombreEstudiante) )
    }

    method perteneceAUnaCarreraElegida(unaMateria) = self.todasLasMateriasDeLasCarrerasElegidas().any( { materiaObligatoria => materiaObligatoria.estaLaMateria(unaMateria) } )

    method estaInscriptoEn(unaMateria) = inscripciones.any( { inscripcion => inscripcion.estaLaMateria(unaMateria) } )

    method cumpleRequisitosParaInscribirse(unaMateria) = unaMateria.requisitos().all( { requisito => materiasAprobadas.contains(requisito) } )
}

class Inscripcion {
    const property estudiante
    const property materia
    const estudiantesInscritos = []
    const listaDeEspera = []

    method realizarInscripcion() {
        if (not self.puedeRealizarInscripcion()) {
            self.error("Ya esta inscripto o no se cumplen los requisitos")
        }
        estudiante.inscribir(materia)
    }

    method puedeRealizarInscripcion() {
        return 
            estudiante.perteneceAUnaCarreraElegida(materia) 
            and not estudiante.aprobo(materia) 
            and not estudiante.estaInscriptoEn(materia) 
            and estudiante.cumpleRequisitosParaInscribirse(materia)
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

