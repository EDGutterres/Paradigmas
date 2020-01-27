from universitario import Universitario

class Professor(Universitario):

    def __init__(self, salario, materia, nome, cpf, anoEntrada):
        super().__init__(nome, cpf, anoEntrada)
        self.salario = salario
        self.materia = materia