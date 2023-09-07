module SelectBox = {
  open Webapi.Dom

  type selectBoxItem = {
    value: string,
    text: string,
  }

  @react.component
  let make = (
    ~values: array<selectBoxItem>,
    ~icon=?,
    ~items: array<selectBoxItem>,
    ~handleSelect,
    ~titleText,
    ~errorMessage: option<string>,
  ) => {
    let (isOpen, setIsOpen) = React.useState(_ => false)
    let selectBoxRef = React.useRef(Js.Nullable.null)

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
      ->Js.Array2.map(v => v.text)
      ->Js.Array2.joinWith(", ")
      ->Js.String2.concat("...")
      ->React.string
    } else if values->Js.Array2.length > 0 {
      values->Js.Array2.map(v => v.text)->Js.Array2.joinWith(", ")->React.string
    } else {
      "Please select"->React.string
    }

    React.useEffect0(() => {
      switch selectBoxRef.current->Js.Nullable.toOption {
      | Some(element') => {
          let handleSelectBox = e => {
            if !(element'->Element.contains(~child=e->Event.target->EventTarget.unsafeAsElement)) {
              setIsOpen(_ => false)
            }
          }

          window->Window.addEventListener("mousedown", handleSelectBox)

          Some(
            () => {
              window->Window.removeEventListener("mousedown", handleSelectBox)
            },
          )
        }

      | _ => None
      }
    })
    <div>
      <span className="text-base font-bold mb-2 block"> {titleText->React.string} </span>
      <button
        className="relative w-full focus:outline-none text-left"
        ref={ReactDOM.Ref.domRef(selectBoxRef)}>
        <div
          className="w-full h-14 px-4 bg-white rounded-xl border border-zinc-200 flex items-center cursor-pointer"
          onClick={dropdownToggle}>
          {icon->Option.getWithDefault(React.null)}
          <div className="grow shrink basis-0 h-6 justify-start items-center flex">
            <div
              className={`grow shrink basis-0 ${values->Js.Array2.length > 0
                  ? "text-neutral-800"
                  : "text-[#C3C5C9]"} text-base font-normal leading-relaxed`}>
              {valueText}
            </div>
          </div>
          <Formula__Icon.ArrowTriangleDownFill
            size=#sm className={`${arrowIconCss} ease-in-out duration-200`}
          />
        </div>
        <TransitionOpacity isVisible={isOpen} duration={200} className="absolute w-full z-10">
          <ul
            className="absolute w-full mt-2 h-56 overflow-auto bg-white rounded-2xl shadow border border-gray-100 flex-col justify-start items-start inline-flex ">
            {items
            ->Array.map(({text, value}) =>
              <li
                key={value}
                className="p-4  w-full bg-white rounded-lg flex justify-between cursor-pointer hover:bg-[#1f20240a] active:bg-[#1f202414]"
                value={value}
                onClick={_ => handleSelect(value)}>
                {text->React.string}
                {switch values->Js.Array2.find(val => val.value === value) {
                | Some(_) => <Formula__Icon.CheckLineRegular size=#xl color=#"primary-contents" />
                | None => React.null
                }}
              </li>
            )
            ->React.array}
          </ul>
        </TransitionOpacity>
      </button>
      {switch errorMessage {
      | Some(message) =>
        <span className="text-[15px] font-normal tracking-tight mt-2 block text-[#ec5990]">
          {message->React.string}
        </span>
      | None => React.null
      }}
    </div>
  }
}
