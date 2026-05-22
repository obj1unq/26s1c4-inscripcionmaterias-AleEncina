class Materia {
    const property cupo
    const property creditos
    const property anio
    var property requisito                       // new Requisito
    const estudiantesInscriptos = []
    const property estrategiaParaListaDeEspera      //new estrategia
    const estudiantesEnEspera = []

    method requisito() {
        return requisito
    }

    method superaElCupo() = estudiantesInscriptos.size() >= self.cupo()
    
    method agregar(estudiante) {
        if (self.superaElCupo()) {
            estrategiaParaListaDeEspera.agregarALaListaDeEspera(estudiante, self)
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

