type records<'a> = {fields: 'a}

type payload<'a> = {records: array<records<'a>>, typecast: bool}

let convertToPayload = input => {
  let payload = {
    records: [],
    typecast: true,
  }

  payload.records
  ->Js.Array2.push({
    fields: input,
  })
  ->ignore

  payload
}
