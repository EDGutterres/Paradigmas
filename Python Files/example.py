import abc

class Band:
    
    def __init__(self, name, genre, foundationYear):
        self.name = name
        self.genre = genre
        self.foundationYear = foundationYear
    
    def setName(self, name):
        self.name = name
    
    def setGenre(self, genre):
        self.genre = genre

    def setFoundationYear(self, foundationYear):
        self.foundationYear = foundationYear

    def getName(self):
        return self.name

    def getGenre(self):
        return self.genre

    def getFoundationYear(self):
        return self.foundationYear


class RockBand(Band, Performable):

    def __init__(self, leader, name, genre, foundationYear):
        super().__init__(name, genre, foundationYear)
        self.leader = leader

    def setFoundationYear(self, foundationYear):
        self.foundationYear = 2019

class Performable:

    def perform():
        #perform a show
        pass

class Magician(Performable):
    
    def __init__(self, name, age):
        self.deck = Deck(52, "Bycicle")
        self.name = name
        self.age = age

class Deck:

    __metaclass__  = abc.ABCMeta

    def __init__(self, numberOfCards, company):
        self.numberOfCards = numberOfCards
        self.company = company

    @staticmethod
    def cardName(number, suit):
        return number + " of " + suit

    @abc.abstractmethod
    def shuffle(self):
        """Method that should do something."""