class Materia {
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
        if(!self.puedeInscribirse(_materia)){
            self.error("Ya esta inscripto o no cumple los requisitos")
        }
        inscripciones.add( new Inscripcion (materia=_materia, estudiante=nombreEstudiante, estado=_materia.) )
    }

    method puedeInscribirse(_materia) = !self.aprobo(_materia) && !inscripciones.any( { inscripcion => inscripcion.estaLaMateria(_materia) } ) 
    && self.todasLasMateriasDeLasCarrerasElegidas().any( { materiaObligatoria => materiaObligatoria.estaLaMateria(_materia) } ) && _materia.tieneRequisitosCumplidos(self)



}


class Inscripcion {
    const property materia
    const property estudiante
    const property estado

    method tieneRequisitosParaInscribirse(unaMateria, unEstudiante) = unaMateria.tieneRequisitosCumplidos(unEstudiante)

    method estaLaMateria(unaMateria) = materia == unaMateria

    method inscribir(unaMateria, unEstudiante) {
        if(!unEstudiante.puedeInscribirse(unaMateria)){
            self.error("Ya esta inscripto o no cumple los requisitos")
        }
        unEstudiante.inscripciones.add( new Inscripcion (materia=unaMateria, estudiante=unEstudiante, estado="inscripto") )
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

