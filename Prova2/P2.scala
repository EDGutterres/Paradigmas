import scala.collection.{IndexedSeq => $}
object skyscraper {

  val n = 6 // N DEVE SER IGUAL AO NUMERO DE ELEMENTOS EM UMA LINHA

  // 390
   val left   = List(2, 1, 2, 2, 2, 2)
   val right  = List(1, 6, 4, 5, 2, 3)
   val up     = List(2, 3, 3, 4, 4, 1)
   val down   = List(3, 3, 4, 1, 2, 3)

  type Board = IndexedSeq[IndexedSeq[Int]]

  def solve(board: Board, cell: Int = 0): Option[Board] = (cell%n, cell/n) match {
    case (r, c) if c == n => Some(board)
    case (r, c) if board(r)(c) > 0 => solve(board, cell + 1) // if the value in position (r)(c) is greater than 0 this means that the cell is already filled. The program tries another cell
    case (r, c) =>

      def cells(i: Int) = Seq(board(r)(i), board(i)(c)) // get the elements in na row/colluns of the actual element
      def guess(x: Int) = solve(board.updated(r, board(r).updated(c, x)), cell + 1) //cria um novo tabuleiro substituindo a posição dada por algum novo valor não ultilizado na linha/coluna e chama o método solve novamente
      val used = board.indices.flatMap(cells)  //cria um conjunto com todos os elementos da linha/coluna que o elemento atual está

      for (x <- ((1 to n).diff(used))) {
        guess(x).foreach{ result =>
          if (validate_grid(result)) {
            return Some(result)
          }
        }
      }

      return None
  }

  def validate_row (pivot: Int, lista: IndexedSeq[Int]): Int = {
    if (lista == Nil) {
      return 0
    } else {
      if (lista.head > pivot) {
        return (1 + (validate_row(lista.head, lista.tail)))
      } else {
        return (validate_row(pivot, lista.tail))
      }
    }
  }

  def validate_rows (lista: List[Int], board: Board): Boolean = {
    if (lista == Nil) {
      // print("returned True validade_rows")
      return true
    } else {
      if (lista.head == 0) {
        return (validate_rows(lista.tail, board.tail))
      } else {
        if (lista.head == validate_row(0, board.head)) {
          return validate_rows(lista.tail, board.tail)
        } else {
          return false
        }
      }
    }
  }

  def reverse_validate_rows (lista: List[Int], board: Board): Boolean = {
    if (lista == Nil) {
      // print("returned True reverse_validade_rows")
      return true
    } else {
      if (lista.head == 0) {
        return (reverse_validate_rows(lista.tail, board.tail))
      } else {
        if (lista.head == validate_row(0, (board.head).reverse)) {
          return reverse_validate_rows(lista.tail, board.tail)
        } else {
          return false
        }
      }
    }
  }

  def validate_grid (board: Board): Boolean = {
    return (validate_rows(left, board)
      && reverse_validate_rows(right, board)
      && validate_rows(up, board.transpose)
      && reverse_validate_rows(down, board.transpose))
  }

  def first_prune (left: List[Int], right: List[Int], up: List[Int], down: List[Int]): Any = {
    var first = IndexedSeq[Int]()
    var second = IndexedSeq(0, 0, 0, 0)
    var third = IndexedSeq(0, 0, 0, 0)
    var fourth = IndexedSeq(0, 0, 0, 0)
    var fifth = IndexedSeq(0, 0, 0, 0)
    var sixth = IndexedSeq[Int]()

    // Pruning left side of the board
    if (left(1) == 1) {second = 6 +: second}
    else {second = 0 +: second}

    if (left(2) == 1) {third = 6 +: third}
    else {third = 0 +: third}

    if (left(3) == 1) {fourth = 6 +: fourth}
    else {fourth = 0 +: fourth}

    if (left(4) == 1) {fifth = 6 +: fifth}
    else {fifth = 0 +: fifth}

    // Pruning right side of the board
    if (right(1) == 1) {second = second :+ 6}
    else {second = second :+ 0}

    if (right(2) == 1) {third = third :+ 6}
    else {third = third :+ 0}

    if (right(3) == 1) {fourth = fourth :+ 6}
    else {fourth = fourth :+ 0}

    if (right(4) == 1) {fifth = fifth :+ 6}
    else {fifth = fifth :+ 0}

    // Pruning the up side of the board
    for (i <- up) {
      if (i == 1){first = first :+ 6}
      else {first = first :+ 0}
    }

    // Pruning the down side of the board
    for (i <- down) {
      if (i == 1){sixth = sixth :+ 6}
      else {sixth = sixth :+ 0}
    }

    return IndexedSeq(first, second, third, fourth, fifth, sixth)
  }

  def main(args: Array[String]) {
    val board_ = first_prune(left,right,up,down)

    val result = solve(board_.asInstanceOf[Board])

    if (result == None) {
      println("Sem solução")
    } else {
      println(result.get.map(_.mkString(" ")).mkString("\n"))
    }
  }
}