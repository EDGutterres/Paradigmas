class Universitario:

    def __init__(self, nome, cpf, anoEntrada):
        self.nome = nome
        self.cpf = cpf
        self.anoEntrada = anoEntrada

    def calcularTempoPermanencia():
        return 2019 - anoEntrada
    
    def getNome(self):
        return self.nome