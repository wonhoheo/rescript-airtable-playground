type owner = {
  id: string,
  email: string,
  name: string,
}

type input = {
  packer: string,
  stage: string,
  country: array<string>,
  email: string,
  contractPerson: string,
  phone: string,
  owner: array<owner>,
  packJunction: array<string>,
  ccEmail: string,
  packerUrl: string,
  website: string,
  lostReason: string,
  testLabel: string,
  firstClass: array<string>,
  secondClass: array<string>,
  product: array<string>,
  leadSource: array<string>,
}

type selectBoxItem = FormControl.SelectBox.selectBoxItem

type onChange<'a> = (ReactEvent.Form.t, 'a) => unit

module Form = ReactHookForm.Make({
  type t = input
})

module FormInput = {
  module Packer = Form.MakeInput({
    type t = string
    let name = "packer"
    let config = ReactHookForm.Rules.makeWithErrorMessage({
      required: {value: true, message: "This is a required field."},
    })
  })

  module Stage = Form.MakeInput({
    type t = string
    let name = "stage"
    let config = ReactHookForm.Rules.makeWithErrorMessage({
      required: {value: true, message: "This is a required field."},
    })
  })

  module Country = Form.MakeInput({
    type t = array<selectBoxItem>
    let name = "country"
    let config = ReactHookForm.Rules.makeWithErrorMessage({
      required: {value: true, message: "This is a required field."},
    })
  })

  module Email = Form.MakeInput({
    type t = string
    let name = "eamil"
    let config = ReactHookForm.Rules.makeWithErrorMessage({
      required: {value: true, message: "This is a required field."},
      pattern: {
        value: RegExp.patternEmail->Js.Re.fromString,
        message: "The email format doesn't fit.",
      },
    })
  })
}

@react.component
let default = () => {
  let result = CustomHooks.useGetCountries(~params="a")

  let makeSelectBoxItem: (~item: CustomHooks.countries) => FormControl.SelectBox.selectBoxItem = (
    ~item: CustomHooks.countries,
  ) => {
    {value: item.id, text: item.name}
  }

  let countriesData = result->Js.Array2.map(item => makeSelectBoxItem(~item))

  let form = Form.use(
    ~config={
      mode: #onChange,
      defaultValues: {
        packer: "",
        stage: "",
        country: [],
        email: "",
        contractPerson: "",
        phone: "",
        owner: [],
        packJunction: [],
        ccEmail: "",
        packerUrl: "",
        website: "",
        lostReason: "",
        testLabel: "",
        firstClass: [],
        secondClass: [],
        product: [],
        leadSource: [],
      },
    },
  )

  // let formState = form->Form.formState
  // let isValid = formState.isValid

  let handleCountry = (~field: FormInput.Country.field, ~value: string) => {
    let isValue = field.value->Array.getBy(country => country.value === value)
    let countryInfo =
      countriesData->Array.getBy(v => v.value === value)->Option.getWithDefault({value, text: ""})

    let result = switch isValue {
    | Some(existCountry) => field.value->Array.keep(country => country.value !== existCountry.value)
    | None => field.value->Array.concat([{value, text: countryInfo.text}])
    }
    field.onChange(result)
  }

  let onSubmit = (input, _) => {
    input->Js.log
  }

  let onError = (error, _) => {
    error->Js.log
  }

  <>
    <div className="my-5">
      <Formula.Text variant=#headline size=#lg weight=#bold>
        {"Packer Register"->React.string}
      </Formula.Text>
    </div>
    <form
      className="flex flex-col gap-y-4"
      onSubmit={form->Form.handleSubmitWithError(onSubmit, onError)}>
      {form->FormInput.Packer.renderController(({field}) => {
        <Formula.TextField
          titleText="Company Name"
          placeholder="Please enter your Company Name"
          state=?{form->FormInput.Packer.error->Option.map(_ => #error)}
          value={field.value}
          onChange={e => field.onChange(ReactEvent.Form.target(e)["value"])}
          hintText=?{form->FormInput.Packer.error->Belt.Option.map(error => error.message)}
        />
      }, ())}
      {form->FormInput.Stage.renderController(({field}) => {
        <Formula.TextField
          titleText="Stage"
          placeholder="Please enter your Stage"
          onChange={e => field.onChange(ReactEvent.Form.target(e)["value"])}
          state=?{form->FormInput.Stage.error->Option.map(_ => #error)}
          hintText=?{form->FormInput.Stage.error->Belt.Option.map(error => error.message)}
        />
      }, ())}
      {form->FormInput.Country.renderController(({field}) => {
        <FormControl.SelectBox
          values={field.value}
          items={countriesData}
          titleText="Country"
          handleSelect={value => handleCountry(~value, ~field)}
        />
      }, ())}
      {form->FormInput.Email.renderController(({field}) => {
        <Formula.TextField
          titleText="Email"
          state=?{form->FormInput.Email.error->Option.map(_ => #error)}
          onChange={e => field.onChange(ReactEvent.Form.target(e)["value"])}
          placeholder="Please enter your email"
          hintText=?{form->FormInput.Email.error->Belt.Option.map(error => error.message)}
        />
      }, ())}
      <Formula.Button.Container _type="submit" color=#primary size=#lg text="Register" />
    </form>
  </>
}
