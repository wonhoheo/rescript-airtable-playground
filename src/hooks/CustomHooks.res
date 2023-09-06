type countries = {
  id: string,
  name: string,
}

let useGetCountries = (~params: string) => {
  let (result, setResult) = React.useState(_ => [])

  React.useEffect0(() => {
    let getApi = async () => {
      await AirtableService.API.getRecords(
        ~url="%F0%9F%8F%B3%EF%B8%8F%E2%80%8D%F0%9F%8C%88Countries",
        ~params=`fields%5B%5D=Name&${params->Js.Global.encodeURI}`,
      )
    }

    getApi()
    ->Promise.thenResolve(res => {
      let result = switch res->Js.Json.decodeObject {
      | Some(json) =>
        json
        ->Js.Dict.get("records")
        ->Belt.Option.flatMap(option => Js.Json.decodeArray(option))
        ->Belt.Option.map(
          records => {
            let result = records->Js.Array2.map(
              json => {
                let record = json->Js.Json.decodeObject
                switch record {
                | Some(record) => {
                    let id =
                      record
                      ->Js.Dict.get("id")
                      ->Option.flatMap(x => Js.Json.decodeString(x))
                      ->Option.getWithDefault("")

                    let name =
                      Js.Dict.get(record, "fields")
                      ->Option.flatMap(
                        fields =>
                          fields
                          ->Js.Json.decodeObject
                          ->Option.flatMap(
                            v =>
                              v
                              ->Js.Dict.get("Name")
                              ->Option.flatMap(name => name->Js.Json.decodeString),
                          ),
                      )
                      ->Option.getWithDefault("")

                    {id, name}
                  }
                | None => {id: "", name: ""}
                }
              },
            )
            result
          },
        )
        ->Option.getExn
      | None => []
      }

      setResult(_ => result)
    })
    ->ignore

    None
  })

  result
}
