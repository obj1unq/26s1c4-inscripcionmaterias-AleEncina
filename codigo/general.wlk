class Materia {
    const materiasCursadas = []


}

class MateriaAprobada {
    const property materia  
    const nota  

    method nota() {
      return nota
    }

    //method esUnaAprobada() = nota.between(7, 10)

    method estaLaMateria(unaMateria) = materia == unaMateria
    
}

class Estudiante{
    //const nombreEstudiante
    const materiasAprobadas = []

    //juan.aprobar(objetos1, 7)
    method aprobar(_materia, _nota){
        if(self.aprobo(_materia)){
            self.error("Ya esta aprobada")
        }
        materiasAprobadas.add( new MateriaAprobada (materia=_materia, nota=_nota))
    }

    method aprobo(unaMateria) = materiasAprobadas.any( { materiaAprobada => materiaAprobada.estaLaMateria(unaMateria) } )

    method cantMateriasAprobadas() = materiasAprobadas.size()

    method promedio() = if(self.noAproboNingunaMateria()) { 0 } else { materiasAprobadas.map( { materiaAprobada => materiaAprobada.nota() } ).average() }
    
    method noAproboNingunaMateria() = materiasAprobadas.isEmpty()

    method todasLasMateriasDe(carreras) = carreras.flatMap( { carrera => carrera.materiasObligatorias() } )


    
}


class Carrera {
    const property nombreCarrera
    const materiasObligatorias

    method materiasObligatorias(){
        return materiasObligatorias
    }

}


/*class CarreraElegida {
    const materiasObligatorias

    method materiasObligatorias(){
        return materiasObligatorias
    }


}*/


class Curso {





}