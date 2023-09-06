open Fetch
type statusCode = int
exception Fetch_error(statusCode)

external airtableApiKey: option<string> = "process.env.NEXT_PUBLIC_AIRTABLE_API_KEY"
external airtableAppId: option<string> = "process.env.NEXT_PUBLIC_AIRTABLE_APP_ID"
let airtableBaseUrl = "https://api.airtable.com/v0"
let apiKey = switch airtableApiKey {
| Some(key) => key
| None => ""
}
let appId = switch airtableAppId {
| Some(id) => id
| None => ""
}

module API = {
  let createRecords = async (~url, ~data) => {
    try {
      let response = await fetch(
        `${airtableBaseUrl}/${appId}/${url}`,
        {
          method: #POST,
          headers: Headers.fromObject({
            "Authorization": `Bearer ${apiKey}`,
            "Content-Type": "application/json",
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

  let getRecords = async (~url, ~params: string) => {
    try {
      let response = await fetch(
        `${airtableBaseUrl}/${appId}/${url}?${params}`,
        {
          method: #GET,
          headers: Headers.fromObject({
            "Authorization": `Bearer ${apiKey}`,
          }),
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
