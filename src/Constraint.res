type strength =
  // errors if not satisfied
  | Required
  // tries as best it can with given priority (higher is stronger)
  | Suggested(int)

type t = {
  strength: strength,
  variables: Belt.Set.String.t,
}
