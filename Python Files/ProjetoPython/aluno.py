from universitario import Universitario

class Aluno(Universitario):
    def __init__(self, matricula, materias, nome, cpf, anoEntrada):
        super().__init__(nome, cpf, anoEntrada)
        self.matricula = matricula
        self.materias = materias
    
    def getMatricula(self):
        return self.matricula