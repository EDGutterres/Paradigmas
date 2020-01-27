from aluno import Aluno
from professor import Professor

class Main:
    if __name__ == "__main__":

        edu = Aluno(172, {"Paradigmas", "TC", "Prob", "Grafos"}, "Eduardo D", 106, 2019)
        print(edu.getNome())
