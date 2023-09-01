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

type owner = {
  id: string,
  email: string,
  name: string,
}

type packerRequestBody = {
  "Packer (no comma)": string,
  "Stage": string,
  "Country": array<string>,
  "Email (1개만)": string,
  "Contact Person": string,
  "Phone": string,
  "Owner": array<owner>,
  "Pack.Test.Junction": array<string>,
  "PackerURL": string,
  "Website": string,
  "Lost Reason": string,
  "Test Label": string,
  "1Sclass": array<string>,
  "2Sclass": array<string>,
  "CC email backup-TBD": string,
  "🏷️ Product": array<string>,
  "Lead Sources": array<string>,
}

module API = {
  let createPacker = async (~url, ~data) => {
    try {
      let response = await fetch(
        `${airtableBaseUrl}/${appId}/${url}`,
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

  let getCountries = async (~params) => {
    try {
      let response = await fetch(
        `${airtableBaseUrl}/${appId}/%F0%9F%8F%B3%EF%B8%8F%E2%80%8D%F0%9F%8C%88Countries?${params}`,
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
