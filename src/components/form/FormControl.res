module SelectBox = {
  type selectBoxItem = {
    value: string,
    text: string,
  }

  @react.component
  let make = (
    ~values: array<string>,
    ~icon=?,
    ~items: array<selectBoxItem>,
    ~handleSelect,
    ~titleText,
  ) => {
    let (isOpen, setIsOpen) = React.useState(_ => false)

    let dropdownToggle = (_: JsxEvent.Mouse.t) => {
      setIsOpen(prev => !prev)
    }

    let arrowIconCss = switch isOpen {
    | true => "rotate-180"
    | false => "rotate-0"
    }

    let valueText = if values->Js.Array2.length > 3 {
      values
      ->Js.Array2.slice(~start=0, ~end_=3)
      ->Js.Array2.joinWith(", ")
      ->Js.String2.concat("...")
      ->React.string
    } else if values->Js.Array2.length > 0 {
      values->Js.Array2.joinWith(", ")->React.string
    } else {
      "선택해주세요"->React.string
    }

    <div className="relative">
      <span className="text-base font-bold mb-2 block"> {titleText->React.string} </span>
      <div
        className="w-full h-14 px-4 bg-white rounded-xl border border-zinc-200 flex items-center cursor-pointer"
        onClick={dropdownToggle}>
        {icon->Option.getWithDefault(React.null)}
        <div className="grow shrink basis-0 h-6 justify-start items-center flex">
          <div
            className="grow shrink basis-0 text-neutral-800 text-base font-normal leading-relaxed">
            {valueText}
          </div>
        </div>
        <Formula__Icon.ArrowTriangleDownFill
          size=#sm className={`${arrowIconCss} ease-in-out duration-200`}
        />
      </div>
      <TransitionOpacity isVisible={isOpen} duration={200}>
        <ul
          className="absolute w-full mt-2 h-56 overflow-auto bg-white rounded-2xl shadow border border-gray-100 flex-col justify-start items-start inline-flex">
          {items
          ->Array.map(({text, value}) =>
            <li
              key={value}
              className="p-4  w-full bg-white rounded-lg flex justify-between cursor-pointer"
              value={value}
              onClick={_ => handleSelect(value)}>
              {text->React.string}
              {switch values->Js.Array2.find(val => val === value) {
              | Some(_) => <Formula__Icon.CheckLineRegular size=#xl color=#"primary-contents" />
              | None => React.null
              }}
            </li>
          )
          ->React.array}
        </ul>
      </TransitionOpacity>
    </div>
  }
}
