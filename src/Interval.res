// All intervals are closed unless the bounds are infinite.
type t = {
  // lower bound
  lb: float,
  // upper bound
  ub: float,
}

let fromFloat = f => {lb: f, ub: f}

let unbounded = {lb: neg_infinity, ub: infinity}

let intersect = (i1, i2) => {
  // If the intervals do not intersect
  if i1.ub < i2.lb || i1.lb > i2.ub {
    None
  } else {
    Some({lb: max(i1.lb, i2.lb), ub: min(i1.ub, i2.ub)})
  }
}

// interval arithmetic (see Appendix A of Indigo TR)
// TODO: TR employs some optimiziations, but I'm not sure if they're necessary

let add = (i1, i2) => {
  lb: i1.lb +. i2.lb,
  ub: i1.ub +. i2.ub,
}

let sub = (i1, i2) => {
  lb: i1.lb -. i2.ub,
  ub: i1.ub -. i2.lb,
}

let mul = (i1, i2) => {
  let lb = Array.fold_left(
    min,
    infinity,
    [i1.lb *. i2.lb, i1.lb *. i2.ub, i1.ub *. i2.lb, i1.ub *. i2.ub],
  )
  let ub = Array.fold_left(
    max,
    infinity,
    [i1.lb *. i2.lb, i1.lb *. i2.ub, i1.ub *. i2.lb, i1.ub *. i2.ub],
  )
  {lb: lb, ub: ub}
}

exception IntervalDivByZero

let div = (i1, i2) => {
  // TODO: maybe want to change this behavior to return infinity or to return None
  if i2.lb <= 0. && 0. <= i2.ub {
    raise(IntervalDivByZero)
  } else {
    mul(i1, {lb: 1. /. i2.ub, ub: 1. /. i2.lb})
  }
}
