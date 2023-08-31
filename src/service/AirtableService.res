open Fetch
type statusCode = int
exception Fetch_error(statusCode)

external airtableApiKey: option<string> = "process.env.NEXT_PUBLIC_AIRTABLE_API_KEY"
let airtableBaseUrl = "https://api.airtable.com/v0"

module API = {
  let createPacker = async (~baseId, ~url, ~data) => {
    let apiKey = switch airtableApiKey {
    | Some(key) => key
    | None => ""
    }

    try {
      let response = await fetch(
        `${airtableBaseUrl}/${baseId}/${url}`,
        {
          method: #POST,
          headers: Headers.fromObject({
            "Authorization": `Bearer ${apiKey}`,
          }),
          body: data->Js.Json.stringifyAny->Belt.Option.getExn->Body.string,
        },
      )

      await Response.json(response)
    } catch {
    | e =>
      switch e {
      | Fetch_error(s) => s->Int.toFloat->Js.Json.number
      | _ => Js.Json.null
      }
    }
  }
}
