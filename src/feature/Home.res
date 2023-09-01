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

module Form = ReactHookForm.Make({
  type t = input
})

module FormInput = {
  module Packer = Form.MakeInput({
    type t = string
    let name = "Packer (no comma)"
    let config = ReactHookForm.Rules.make({required: true})
  })
}

@react.component
let default = () => {
  let result = CustomHooks.useGetCountries(~params="a")

  result->Js.log

  // let form = Form.use(
  //   ~config={
  //     mode: #onChange,
  //     defaultValues: {
  //       packer: "",
  //       stage: "",
  //       country: [],
  //       email: "",
  //       contractPerson: "",
  //       phone: "",
  //       owner: [],
  //       packJunction: [],
  //       ccEmail: "",
  //       packerUrl: "",
  //       website: "",
  //       lostReason: "",
  //       testLabel: "",
  //       firstClass: [],
  //       secondClass: [],
  //       product: [],
  //       leadSource: [],
  //     },
  //   },
  // )

  <div>
    <Formula.Text variant=#headline size=#lg weight=#bold>
      {"Packer Register"->React.string}
    </Formula.Text>
    <form>
      <Formula.TextField titleText="Company Name" />
    </form>
  </div>
}
