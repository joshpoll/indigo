type t = {id: string, bounds: Interval.t}

let tighten = (v: t, i: Interval.t) =>
  switch Interval.intersect(v.bounds, i) {
  | Some(i) => {...v, bounds: i}
  | None =>
    let {lb: vLB, ub: vUB} = v.bounds
    if v.bounds.ub < i.lb {
      {...v, bounds: {lb: vUB, ub: vUB}}
    } else {
      {...v, bounds: {lb: vLB, ub: vLB}}
    }
  }
